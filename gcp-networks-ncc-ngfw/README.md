self link - https://github.com/GoogleCloudZone/gcp-landing-zone/issues/5

# GCP NCC, NGFW and Armor deployment

## Deployment
```
# deploy
./deployment.sh -c true -d false -p true -b ops-cicd-olx
# failed - delete created project
./deployment.sh -c false -d true -p false -b ops-cicd-olx -s ncc-ngfw-olx-1663
# retry
./deployment.sh -c true -d false -p true -b ops-cicd-olx
```

## Quickstart

### Create

```
michaelobrien@mbp7 cloud-run-java % ./deployment.sh -c true -d false -p true -b ops-cicd-olx                            

```

### Delete

```
michaelobrien@mbp7 cloud-run-java % ./deployment.sh -c false -d true -p false -b ops-cicd-olx -s ncc-ngfw-olx-6734

```
