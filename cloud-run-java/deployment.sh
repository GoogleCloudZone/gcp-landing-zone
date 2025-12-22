#!/bin/bash
#
# for eash of override - key/value pairs for constants - shared by all scripts
# example
# deploy
#./deployment.sh -c true -d false -p true -b ops-cicd-olx
# failed - delete created project
#./deployment.sh -c false -d true -p false -b ops-cicd-olx -s cloud-run-arch-olx-1663
# retry
#./deployment.sh -c true -d false -p true -b ops-cicd-olx

usage() {
  cat <<EOF
Usage: $0 [PARAMs]
example 
EOF
}

source ./vars.sh

deployment() {
  echo "Date: $(date)"
  echo "Timestamp: $(date +%s)"
  echo "$UNIQUE"
  echo "running with create=${CREATE_PROJ} delete=${DELETE_PROJ} boot_project_id=${BOOT_PROJECT_ID}"

  # verify that the following api's are enabled on the boot project
  # to describe functions
  gcloud config set project "${BOOT_PROJECT_ID}"
  gcloud services enable run.googleapis.com
  #gcloud services enable cloudfunctions.googleapis.com
  gcloud services enable cloudresourcemanager.googleapis.com

  if [[ "$CREATE_PROJ" != false ]]; then
    # linux
    #STREAM_PROJECT_RAND=$(shuf -i 0-10000 -n 1)
    # osx
    STREAM_PROJECT_RAND=$(jot -r 1 1000 10000)
    STREAM_PROJECT_ID=${STREAM_PROJECT_NAME_PREFIX}-${STREAM_PROJECT_RAND}
    echo "Creating project: $STREAM_PROJECT_ID"
  else
    #STREAM_PROJECT_ID=${STREAM_PROJECT_ID_PASSED}
    echo "Reusing project: $STREAM_PROJECT_ID"
  fi

  echo "STREAM_PROJECT_ID: $STREAM_PROJECT_ID"

  if [[ "$CREATE_PROJ" != false ]]; then
    # create project
    BILLING_FORMAT="--format=value(billingAccountName)"
    BILLING_ID=$(gcloud billing projects describe $BOOT_PROJECT_ID $BILLING_FORMAT | sed 's/.*\///')
    ORG_ID=$(gcloud projects get-ancestors $BOOT_PROJECT_ID --format='get(id)' | tail -1)
    #EMAIL=$(gcloud config list --format json|jq .core.account | sed 's/"//g')
    EMAIL=$SUPER_ADMIN_EMAIL

    echo "Creating project: ${STREAM_PROJECT_ID} on folder: ${ROOT_FOLDER_ID}"
    gcloud projects create "$STREAM_PROJECT_ID" --name="${STREAM_PROJECT_ID}" --set-as-default --folder="$ROOT_FOLDER_ID"
    gcloud billing projects link "${STREAM_PROJECT_ID}" --billing-account "${BILLING_ID}"  
    gcloud config set project "${STREAM_PROJECT_ID}"
    # add labels
    gcloud alpha projects update $STREAM_PROJECT_ID --update-labels=$PROJECT_LABELS
   

    # service account

    # iam roles for user

    # iam roles for service account
  
    # project services enablement

    # enable apis
    echo "Enabling APIs"
    gcloud services enable cloudapis.googleapis.com
    #gcloud services enable cloudfunctions.googleapis.com
    gcloud services enable run.googleapis.com
    gcloud services enable container.googleapis.com
    gcloud services enable cloudbuild.googleapis.com
    gcloud services enable artifactregistry.googleapis.com
    gcloud services enable pubsub.googleapis.com
    #gcloud services enable cloudbilling.googleapis.com
    # gcloud services enable artifactregistry.googleapis.com
    gcloud services enable compute.googleapis.com
    #gcloud services enable storage-component.googleapis.com 
    #gcloud services enable cloudkms.googleapis.com 
    #gcloud services enable logging.googleapis.com 
    # BigQuery ok
    #gcloud services enable bigquerymigration.googleapis.com
    #gcloud services enable bigquery.googleapis.com
    #gcloud services enable bigquerystorage.googleapis.com
    #gcloud services enable krmapihosting.googleapis.com 
    #gcloud services enable cloudresourcemanager.googleapis.com 

    # create bucket

    # create cloud function

    # BQ schema
  
    # Logging
  fi

  if [[ "$PROVISION_PROJ" != false ]]; then
    gcloud config set project "${STREAM_PROJECT_ID}"
    echo "current project switched to "
    gcloud config get project

    # The service account running this build does not have permission to write logs. To fix this, grant the Logs Writer (roles/logging.logWriter) role to the service account.
    # set roles/logging.logWriter on project id service account - -compute@developer.gserviceaccount.com
    PROJECT_NUMBER=$(gcloud projects list --filter="${STREAM_PROJECT_ID}" '--format=value(PROJECT_NUMBER)')
    echo "PROJECT_NUMBER: $PROJECT_NUMBER"
    SA_EMAIL=$PROJECT_NUMBER-compute@developer.gserviceaccount.com

    # owner for now (redundant)
    gcloud projects add-iam-policy-binding $STREAM_PROJECT_ID --member="user:${SUPER_ADMIN_EMAIL}" --role=roles/owner --quiet > /dev/null 1>&1
    echo "owner on project $STREAM_PROJECT_ID for $SUPER_ADMIN_EMAIL"
    # for ability to log entries
    echo "bind $SA_EMAIL "
    gcloud organizations add-iam-policy-binding "${ORG_ID}" --member="serviceAccount:${SA_EMAIL}" --role=roles/logging.logWriter --condition=None --quiet  > /dev/null 1>&1
    # reading images - redundant
    gcloud projects add-iam-policy-binding $STREAM_PROJECT_ID --member="serviceAccount:${SA_EMAIL}" --role=roles/artifactregistry.reader --quiet > /dev/null 1>&1
    # set on internal SA - required - see https://github.com/GoogleCloudZone/gcp-landing-zone/issues/3#issuecomment-3679745837
    CLOUD_RUN_SA_EMAIL=service-$PROJECT_NUMBER@serverless-robot-prod.iam.gserviceaccount.com
    # some orgs need --condition=None
    gcloud projects add-iam-policy-binding $PROJECT_CICD_ARTIFACT_REGISTRY --member="serviceAccount:${CLOUD_RUN_SA_EMAIL}" --role=roles/artifactregistry.reader --condition=None --quiet > /dev/null 1>&1
    
    echo "wait 60 sec for SA roles to propagate"
    sleep 60

    #docker tag obrienlabs/magellan-nbi:0.0.4-ia64 us-central1-docker.pkg.dev/biometric-backend-cr-man-old/magellan/magellan-nbi:0.0.4-ia64
    #docker push central1-docker.pkg.dev/biometric-backend-cr-man-old/magellan/magellan-nbi:0.0.4-ia64
    echo "provisioning to ${STREAM_PROJECT_ID}"

    gcloud alpha run deploy canary-java-springboot \
      --image=northamerica-northeast1-docker.pkg.dev/${PROJECT_CICD_ARTIFACT_REGISTRY}/canary-java-springboot/canary-java-springboot:latest \
      --no-invoker-iam-check \
      --port=8080 \
      --service-account=${SA_EMAIL} \
      --no-cpu-throttling \
      --execution-environment=gen2 \
      --no-cpu-boost \
      --region=${REGION} \
      --allow-unauthenticated \
      --project=${STREAM_PROJECT_ID}
    
    #gcloud functions deploy ${HTTP_FUNCTION_NAME} \
    #  --gen2 \
    #  --allow-unauthenticated \
    #  --runtime=java17 \
    #  --region=${REGION} \
    #  --source=. \
    #  --entry-point=${JAVA_FQ_CLASSNAME} \
    #  --memory=512MB \
    #  --trigger-http 

    # describe URL regardless of gen 1 or 2
    # verify
    #https://canary-java-springboot-890694568874.northamerica-northeast1.run.app/canary/api/activeId
    echo "Cloud Run URL for project ${STREAM_PROJECT_ID} is the following"
    #gcloud functions describe ${HTTP_FUNCTION_NAME} --region=${REGION} --format="value(httpsTrigger.url, serviceConfig.uri)" --project=${STREAM_PROJECT_ID}
    #cd ../../../
  fi

  if [[ "$DELETE_PROJ" != false ]]; then
    # delete custom service account
    PROJECT_NUMBER=$(gcloud projects list --filter="${STREAM_PROJECT_ID}" '--format=value(PROJECT_NUMBER)')
    echo "PROJECT_NUMBER: $PROJECT_NUMBER"
    SA_EMAIL=$PROJECT_NUMBER-compute@developer.gserviceaccount.com


    # disable billing before deletion - to preserve the project/billing quota
    gcloud billing projects unlink "${STREAM_PROJECT_ID}"
    gcloud projects delete "$STREAM_PROJECT_ID" --quiet
  fi

  # return back from etherial project
  gcloud config set project "${BOOT_PROJECT_ID}"  

  end=`date +%s`
  runtime=$((end-start))
  echo "Total Duration: ${runtime} sec"
  echo "Date: $(date)"
  echo "Timestamp: $(date +%s)"
}

UNIQUE=olx
CREATE_PROJ=false
DELETE_PROJ=false
PROVISION_PROJ=false
STREAM_PROJECT_ID=
BOOT_PROJECT_ID=
while getopts ":c:d:b:p:s:u:" PARAM; do
  case $PARAM in
    c)
      CREATE_PROJ=${OPTARG}
      ;;
    d)
      DELETE_PROJ=${OPTARG}
      ;;
    p)
      PROVISION_PROJ=${OPTARG}
      ;;
    b)
      BOOT_PROJECT_ID=${OPTARG}
      ;;
    s)
      STREAM_PROJECT_ID=${OPTARG}
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

echo "Options are: -c true/false (create) -d (delete) true/false (delete proj) -p provision (true/false) -b BOOT_PROJ_ID -s (for delete only) STREAM_PROJECT_ID"

if [[ -z $UNIQUE ]]; then
  usage
  exit 1
fi

echo "existing project: $PROJECT_ID"
deployment "$CREATE_PROJ" "$DELETE_PROJ" "$PROVISION_PROJ" "$BOOT_PROJECT_ID" "$STREAM_PROJECT_ID"
printf "**** Done ****\n"
