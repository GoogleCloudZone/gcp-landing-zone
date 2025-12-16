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
