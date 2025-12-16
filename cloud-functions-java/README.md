self link - https://github.com/GoogleCloudZone/gcp-landing-zone/issues/2

# GCP Cloud Functions Deployment

## Deployment
```
# deploy
./deployment.sh -c true -d false -p true -b ops-cicd-olx
# failed - delete created project
./deployment.sh -c false -d true -p false -b ops-cicd-olx -s cloud-functions-arch-olx-1663
# retry
./deployment.sh -c true -d false -p true -b ops-cicd-olx


echo "Functions URL for project ${STREAM_PROJECT_ID} is the following"
gcloud functions describe ${HTTP_FUNCTION_NAME} --region=us-central1 --format="value(httpsTrigger.url, serviceConfig.uri)" --project=${STREAM_PROJECT_ID}

```

## Quickstart

### Create
```
michaelobrien@mbp8 cloud-functions-java % ./deployment.sh -c true -d false -p true -b ops-cicd-olx                            
Options are: -c true/false (create) -d (delete) true/false (delete proj) -p provision (true/false) -b BOOT_PROJ_ID -s (for delete only) STREAM_PROJECT_ID
existing project: 
Date: Tue 16 Dec 2025 16:48:00 EST
Timestamp: 1765921680
olx
running with create=true delete=false boot_project_id=ops-cicd-olx
Creating project: cloud-functions-arch-olx-1486
STREAM_PROJECT_ID: cloud-functions-arch-olx-1486
WARNING: Your active project does not match the quota project in your local Application Default Credentials file. This might result in unexpected quota issues.

To update your Application Default Credentials quota project, use the `gcloud auth application-default set-quota-project` command.
Updated property [core/project].
Creating project: cloud-functions-arch-olx-1486 on folder: 579268326076
Create in progress for [https://cloudresourcemanager.googleapis.com/v1/projects/cloud-functions-arch-olx-1486].
Waiting for [operations/create_project.global.6196592764421500369] to finish...done.                                                                                                                                                      
Enabling service [cloudapis.googleapis.com] on project [cloud-functions-arch-olx-1486]...
Operation "operations/acat.p2-291916057700-6d9acdf0-884c-4b6d-b78f-3fee311b50c8" finished successfully.
Updated property [core/project] to [cloud-functions-arch-olx-1486].
billingAccountName: billingAccounts/01BCCE-4EC0EE-DC58C8
billingEnabled: true
name: projects/cloud-functions-arch-olx-1486/billingInfo
projectId: cloud-functions-arch-olx-1486
WARNING: Your active project does not match the quota project in your local Application Default Credentials file. This might result in unexpected quota issues.

To update your Application Default Credentials quota project, use the `gcloud auth application-default set-quota-project` command.
Updated property [core/project].
Operation "operations/acf.p2-291916057700-6af1979d-d678-44a2-a2ae-93c294b21198" finished successfully.
Operation "operations/acf.p2-291916057700-0c4c350c-4d68-4560-986a-483af800d302" finished successfully.
Operation "operations/acf.p2-291916057700-2c21205a-3bd4-4be3-bef0-926336d74414" finished successfully.
WARNING: Your active project does not match the quota project in your local Application Default Credentials file. This might result in unexpected quota issues.

To update your Application Default Credentials quota project, use the `gcloud auth application-default set-quota-project` command.
Updated property [core/project].
current project switched to 
cloud-functions-arch-olx-1486
PROJECT_NUMBER: 291916057700
bind 291916057700-compute@developer.gserviceaccount.com
Updated IAM policy for organization [1064386348915].
wait 60 sec
provisioning to cloud-functions-arch-olx-1486
Preparing function...done.                                                                                                                                                                                                                
X Deploying function...                                                                                                                                                                                                                   
    [Build] Logs are available at [https://console.cloud.google.com/cloud-build/builds;region=northamerica-northeast1/6ad286ef-66cf-4c06-b914-837a71bccee5?project=291916057700]                                                          
  ✓ [Service]                                                                                                                                                                                                                             
  . [ArtifactRegistry]                                                                                                                                                                                                                    
  . [Healthcheck]                                                                                                                                                                                                                         
  . [Triggercheck]                                                                                                                                                                                                                        
Completed with warnings:                                                                                                                                                                                                                  
  [WARNING] Failed to find vendored functions-framework dependency. Installing version 1.4.1:
<nil>
You can view your function in the Cloud Console here: https://console.cloud.google.com/functions/details/northamerica-northeast1/ptlm?project=cloud-functions-arch-olx-1486

buildConfig:
  automaticUpdatePolicy: {}
  build: projects/291916057700/locations/northamerica-northeast1/builds/6ad286ef-66cf-4c06-b914-837a71bccee5
  dockerRegistry: ARTIFACT_REGISTRY
  dockerRepository: projects/cloud-functions-arch-olx-1486/locations/northamerica-northeast1/repositories/gcf-artifacts
  entryPoint: gcfv2.PeriodicTableLMHttpFunction
  runtime: java17
  serviceAccount: projects/cloud-functions-arch-olx-1486/serviceAccounts/291916057700-compute@developer.gserviceaccount.com
  source:
    storageSource:
      bucket: gcf-v2-sources-291916057700-northamerica-northeast1
      generation: '1765921811998421'
      object: ptlm/function-source.zip
  sourceProvenance:
    resolvedStorageSource:
      bucket: gcf-v2-sources-291916057700-northamerica-northeast1
      generation: '1765921811998421'
      object: ptlm/function-source.zip
createTime: '2025-12-16T21:50:12.293640144Z'
environment: GEN_2
labels:
  deployment-tool: cli-gcloud
name: projects/cloud-functions-arch-olx-1486/locations/northamerica-northeast1/functions/ptlm
serviceConfig:
  allTrafficOnLatestRevision: true
  availableCpu: '0.3333'
  availableMemory: 512M
  environmentVariables:
    LOG_EXECUTION_ID: 'true'
  ingressSettings: ALLOW_ALL
  maxInstanceRequestConcurrency: 1
  revision: ptlm-00001-kot
  service: projects/cloud-functions-arch-olx-1486/locations/northamerica-northeast1/services/ptlm
  serviceAccountEmail: 291916057700-compute@developer.gserviceaccount.com
  timeoutSeconds: 60
  uri: https://ptlm-jjuct7m6da-nn.a.run.app
state: ACTIVE
updateTime: '2025-12-16T21:51:58.900495009Z'
url: https://northamerica-northeast1-cloud-functions-arch-olx-1486.cloudfunctions.net/ptlm
Functions URL for project cloud-functions-arch-olx-1486 is the following
	https://ptlm-jjuct7m6da-nn.a.run.app
WARNING: Your active project does not match the quota project in your local Application Default Credentials file. This might result in unexpected quota issues.

To update your Application Default Credentials quota project, use the `gcloud auth application-default set-quota-project` command.
Updated property [core/project].
Total Duration: 1765921922 sec
Date: Tue 16 Dec 2025 16:52:02 EST
Timestamp: 1765921922
**** Done ****
```

### Delete

```
michaelobrien@mbp8 cloud-functions-java % ./deployment.sh -c false -d true -p false -b ops-cicd-olx -s cloud-functions-arch-olx-1486
Options are: -c true/false (create) -d (delete) true/false (delete proj) -p provision (true/false) -b BOOT_PROJ_ID -s (for delete only) STREAM_PROJECT_ID
existing project: 
Date: Tue 16 Dec 2025 16:56:11 EST
Timestamp: 1765922171
olx
running with create=false delete=true boot_project_id=ops-cicd-olx
Reusing project: cloud-functions-arch-olx-1486
STREAM_PROJECT_ID: cloud-functions-arch-olx-1486
billingAccountName: ''
billingEnabled: false
name: projects/cloud-functions-arch-olx-1486/billingInfo
projectId: cloud-functions-arch-olx-1486
Deleted [https://cloudresourcemanager.googleapis.com/v1/projects/cloud-functions-arch-olx-1486].

You can undo this operation for a limited period by running the command below.
    $ gcloud projects undelete cloud-functions-arch-olx-1486

See https://cloud.google.com/resource-manager/docs/creating-managing-projects for information on shutting down projects.
WARNING: Your active project does not match the quota project in your local Application Default Credentials file. This might result in unexpected quota issues.

To update your Application Default Credentials quota project, use the `gcloud auth application-default set-quota-project` command.
Updated property [core/project].
Total Duration: 1765922177 sec
Date: Tue 16 Dec 2025 16:56:17 EST
Timestamp: 1765922177
**** Done ****
```
