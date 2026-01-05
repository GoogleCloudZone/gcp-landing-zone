
# Google App Engine - (appspot) Archetype
This GCP archetype is an example GAE standard deployment of a Java based REST application

- https://docs.cloud.google.com/appengine/docs/standard/java-gen2/runtime

## Container
We are using the standard Java 25 / Spring Boot 4 canary app (for CVE testing, Cloud Build deployment and Artifact Registry stoarage/scanning)

This container application code is built from a GCP CSR  or ADO repo at 
- https://github.com/ObrienlabsDev/canary-java-springboot
- https://source.cloud.google.com/ops-cicd-olx/ops-cicd-ot/+/master:canary-java-springboot/

## CSR
- create or update a CICD project to hold the repos

## Set services on the boot project

```
gcloud auth login
gcloud config set project archetypes-boot-ot
# running terraform in the project above requres below
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable appengine.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com


gcloud services enable sourcerepo.googleapis.com
# both ar and cb required for containerization of the war/jar
gcloud services enable artifactregistry.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

- create repo, upload key, populate
```
ssh-keygen -t rsa -C "mich....yz"
chmod 400 obr...-cloud-shell-csr-202512
eval `ssh-agent`
ssh-add ~/.ssh/ob*
# upload to CSR/user/ssh-keys
cat ~/.ssh/ob*.pub
```
- https://source.cloud.google.com/user/ssh_keys?register=true 

```
git clone ssh://mic..yz@source.developers.google.com:2022/p/op..lx/r/ops-cicd-ot

```

## Create a terraform state storage bucket
- nane1 regional bucket
```
gcloud storage buckets create gs://gcp-archetypes-state --location=northamerica-northeast1
```

## Quickstart

```
gcloud config set project archetypes-boot-ot
cd wse_github/gcp-landing-zone/google-app-engine-java
terraform init
terraform validate
terraform plan
terraform apply --auto-approve

The appspot service account must have write permissions for cloud build and artifact registry as well as write access to google storage - terraform apply may need to be run twice until I fix timing using the proper depends_on

After terraform completes, switch to the generated GAE project and deploy a version of the app in app/*
Note the config in app.yaml.


runtime: java25 
env: standard
entrypoint: "java -jar app/canary-0.0.1-SNAPSHOT.jar" 


gcloud config set project gae-sandbox-3z8g-8f97
gcloud app deploy --project=gae-sandbox-3z8g-8f97 --quiet
This may need to be run twice - to kick in the two service account role grants - or wait a couple min for propagation

gcloud app deploy --project=gae-sandbox-3z8g-8f97 --quiet

you will see

michael@cloudshell:~/wse_github/gcp-landing-zone/google-app-engine-java (gae-sandbox-b8rb-d4f4)$ gcloud app deploy --project=gae-sandbox-b8rb-d4f4 --quiet
WARNING: You might be using automatic scaling for a standard environment deployment, without providing a value for automatic_scaling.max_instances. Starting from March, 2025, App Engine sets the automatic scaling maximum instances default for standard environment deployments to 20. This change doesn't impact existing apps. To override the default, specify the new max_instances value in your app.yaml file, and deploy a new version or redeploy over an existing version. For details on max_instances, see https://cloud.google.com/appengine/docs/standard/reference/app-yaml.md#scaling_elements. 

Services to deploy:

descriptor:                  [/home/michael/wse_github/gcp-landing-zone/google-app-engine-java/app.yaml]
source:                      [/home/michael/wse_github/gcp-landing-zone/google-app-engine-java]
target project:              [gae-sandbox-b8rb-d4f4]
target service:              [default]
target version:              [20260105t034339]
target url:                  [https://gae-sandbox-b8rb-d4f4.nn.r.appspot.com]
target service account:      [gae-sandbox-b8rb-d4f4@appspot.gserviceaccount.com]


Beginning deployment of service [default]...
Uploading 2 files to Google Cloud Storage
50%
100%
100%
File upload done.
Waiting for operation [apps/gae-sandbox-b8rb-d4f4/operations/0cf192e6-1562-43dc-9525-6b5a68a56521] to complete...done.                                                                                                                                                          
Setting traffic split for service [default]...done.                                                                                                                                                                                                                             
Deployed service [default] to [https://gae-sandbox-b8rb-d4f4.nn.r.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s default

To view your application in the web browser run:
  $ gcloud app browse
michael@cloudshell:~/wse_github/gcp-landing-zone/google-app-engine-java (gae-sandbox-b8rb-d4f4)$ gcloud app browse
Did not detect your browser. Go to this link to view your app:
https://gae-sandbox-b8rb-d4f4.nn.r.appspot.com/canary 

```

## Deployment

## URLs
- javascript canvas - https://<project_id>>.nn.r.appspot.com/canary/
- health check - https://<project_id>>.nn.r.appspot.com/canary/api/health
- json simulation - https://<project_id>>nn.r.appspot.com/canary/api/activeId

## Delete
- no need to delete the cloud build history, artifact repository or google app engine versions - all of these are generated and out-of-band of terraform state.

```
michael@cloudshell:~/wse_github/gcp-landing-zone/google-app-engine-java (gae-sandbox-3z8g-8f97)$ gcloud config set project archetypes-boot-ot
terraform init
terraform plan
terraform destroy
```

## Links
