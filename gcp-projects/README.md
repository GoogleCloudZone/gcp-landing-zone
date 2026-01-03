
# Google App Engine - (appspot) Archetype
This GCP archetype is an example GAE standard deployment of a Java based REST application

- https://docs.cloud.google.com/appengine/docs/standard/java-gen2/runtime

## Container
We are using the standard Java 25 / Spring Boot 4 canary app (for CVE testing, Cloud Build deployment and Artifact Registry stoarage/scanning)

This container application code is built GCP CSR at

## CSR
- create or update a CICD project to hold the repos

```
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

## Quickstart

## Deployment

## Links
