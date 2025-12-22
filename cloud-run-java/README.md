self link - https://github.com/GoogleCloudZone/gcp-landing-zone/issues/3

# GCP Cloud Run Deployment

## Deployment
```
# deploy
./deployment.sh -c true -d false -p true -b ops-cicd-olx
# failed - delete created project
./deployment.sh -c false -d true -p false -b ops-cicd-olx -s cloud-run-arch-olx-1663
# retry
./deployment.sh -c true -d false -p true -b ops-cicd-olx
```

## Quickstart

### Create

```
michaelobrien@mbp7 cloud-run-java % ./deployment.sh -c true -d false -p true -b ops-cicd-olx                            
Options are: -c true/false (create) -d (delete) true/false (delete proj) -p provision (true/false) -b BOOT_PROJ_ID -s (for delete only) STREAM_PROJECT_ID
existing project: 
Date: Sun Dec 21 20:00:46 EST 2025
Timestamp: 1766365246
olx
running with create=true delete=false boot_project_id=ops-cicd-olx
Updated property [core/project].
Creating project: cloud-run-arch-olx-6734
STREAM_PROJECT_ID: cloud-run-arch-olx-6734
Creating project: cloud-run-arch-olx-6734 on folder: 579268326076
Create in progress for [https://cloudresourcemanager.googleapis.com/v1/projects/cloud-run-arch-olx-6734].
Waiting for [operations/create_project.global.5726023826951461023] to finish...done.                                                                                                                                                                                        
Enabling service [cloudapis.googleapis.com] on project [cloud-run-arch-olx-6734]...
Operation "operations/acat.p2-923190755558-d2d94dc7-7b3a-4e52-855c-992c2d0552e8" finished successfully.
Updated property [core/project] to [cloud-run-arch-olx-6734].
billingAccountName: billingAccounts/01BCCE-4EC0EE-DC58C8
billingEnabled: true
name: projects/cloud-run-arch-olx-6734/billingInfo
projectId: cloud-run-arch-olx-6734
Updated property [core/project].
Updated [https://cloudresourcemanager.googleapis.com/v1/projects/cloud-run-arch-olx-6734].
PROJECT_ID               NAME                     PROJECT_NUMBER  ENVIRONMENT
cloud-run-arch-olx-6734  cloud-run-arch-olx-6734  923190755558
Enabling APIs
Operation "operations/acf.p2-923190755558-28ee6f10-72c4-4823-8d11-d529d7d4b8cd" finished successfully.
Operation "operations/acf.p2-923190755558-5079c710-9853-4e5e-a422-da1b351db126" finished successfully.
Operation "operations/acf.p2-923190755558-a788e150-8877-4d34-bd36-5476f74c6687" finished successfully.
Updated property [core/project].
current project switched to 
Your active configuration is: [obrienlabs-dev]
cloud-run-arch-olx-6734
PROJECT_NUMBER: 923190755558
Updated IAM policy for project [cloud-run-arch-olx-6734].
owner on project cloud-run-arch-olx-6734 for michael@obrienlabs.xyz
bind 923190755558-compute@developer.gserviceaccount.com 
Updated IAM policy for organization [1064386348915].
Updated IAM policy for project [cloud-run-arch-olx-6734].
Updated IAM policy for project [ops-cicd-olx].
wait 60 sec for SA roles to propagate
provisioning to cloud-run-arch-olx-6734


Deploying container to Cloud Run service [canary-java-springboot] in project [cloud-run-arch-olx-6734] region [northamerica-northeast1]
✓ Deploying new service... Done.                                                                                                                                                                                                                                            
  ✓ Creating Revision...                                                                                                                                                                                                                                                    
  ✓ Routing traffic...                                                                                                                                                                                                                                                      
  ✓ Setting IAM Policy...                                                                                                                                                                                                                                                   
Done.                                                                                                                                                                                                                                                                       
Service [canary-java-springboot] revision [canary-java-springboot-00001-cqr] has been deployed and is serving 100 percent of traffic.
Service URL: https://canary-java-springboot-923190755558.northamerica-northeast1.run.app
Cloud Run URL for project cloud-run-arch-olx-6734 is the following
Updated property [core/project].
Total Duration: 1766365446 sec
Date: Sun Dec 21 20:04:06 EST 2025
Timestamp: 1766365446
**** Done ****

```

### Delete

```
michaelobrien@mbp7 cloud-run-java % ./deployment.sh -c false -d true -p false -b ops-cicd-olx -s cloud-run-arch-olx-6734
Options are: -c true/false (create) -d (delete) true/false (delete proj) -p provision (true/false) -b BOOT_PROJ_ID -s (for delete only) STREAM_PROJECT_ID
existing project: 
Date: Sun Dec 21 21:47:52 EST 2025
Timestamp: 1766371672
olx
running with create=false delete=true boot_project_id=ops-cicd-olx
Updated property [core/project].
Reusing project: cloud-run-arch-olx-6734
STREAM_PROJECT_ID: cloud-run-arch-olx-6734
PROJECT_NUMBER: 923190755558
billingAccountName: ''
billingEnabled: false
name: projects/cloud-run-arch-olx-6734/billingInfo
projectId: cloud-run-arch-olx-6734
Deleted [https://cloudresourcemanager.googleapis.com/v1/projects/cloud-run-arch-olx-6734].

You can undo this operation for a limited period by running the command below.
    $ gcloud projects undelete cloud-run-arch-olx-6734

See https://cloud.google.com/resource-manager/docs/creating-managing-projects for information on shutting down projects.
Updated property [core/project].
Total Duration: 1766371682 sec
Date: Sun Dec 21 21:48:02 EST 2025
Timestamp: 1766371682
**** Done ****
```
