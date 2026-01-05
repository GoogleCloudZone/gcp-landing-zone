
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
gcloud config set project lz-ado-xyz-boot-ot
cd wse_github/gcp-landing-zone/google-app-engine-java
terraform init
terraform validate
terraform plan
terraform apply --auto-approve

The appspot service account must have write permissions for cloud build and artifact registry as well as write access to google storage.

After terraform completes, switch to the generated GAE project and deploy a version of the app in app/*
Note the config in app.yaml.


runtime: java25 
env: standard
entrypoint: "java -jar app/canary-0.0.1-SNAPSHOT.jar" 


gcloud config set project gae-sandbox-3z8g-8f97
gcloud app deploy --project=gae-sandbox-3z8g-8f97 --quiet
```

## Deployment

## Delete
- no need to delete the cloud build history, artifact repository or google app engine versions - all of these are generated and out-of-band of terraform state.

```
michael@cloudshell:~/wse_github/gcp-landing-zone/google-app-engine-java (gae-sandbox-3z8g-8f97)$ gcloud config set project archetypes-boot-ot
terraform init
terraform plan
terraform destroy
```

## Links
