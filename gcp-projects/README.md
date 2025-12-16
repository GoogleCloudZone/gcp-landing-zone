
# Google App Engine - (appspot) Archetype
This GCP archetype is an example GAE standard deployment of a Java based REST application

- https://docs.cloud.google.com/appengine/docs/standard/java-gen2/runtime

## Container
We are using the standard Java 25 / Spring Boot 4 canary app (for CVE testing, Cloud Build deployment and Artifact Registry stoarage/scanning)

This container application code is built GCP CSR at

## CSR
 - create repo, upload key, populate
 - ```
ssh-keygen -t rsa -C "mich...labs.tech"
chmod 400 obr...ch-cloud-shell-202512
eval `ssh-agent`
ssh-add ~/.ssh/ob*
# upload to CSR/user/ssh-keys
cat ~/.ssh/ob*

```
- https://source.cloud.google.com/user/ssh_keys?register=true 

clone
```
git clone
```

## Quickstart

## Deployment

## Links
