
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
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable sourcerepo.googleapis.com
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
cd wse_github/gcp-landing-zone/gcp-projects
terraform init
terraform plan
terraform apply --auto-approve
```

## Deployment

## Links
