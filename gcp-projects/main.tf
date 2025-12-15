# prereq
# on boot project enable
# App Engine Admin API appengine.googleapis.com
# Compute API compute.googleapis.com


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project.html

#resource "google_project" "my_project" {
#  name       = "obrienlabs-test"
#  project_id = "obrienlabs-test-001"
#  org_id     = "1775303217800"
#}

# https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest
# https://github.com/terraform-google-modules/terraform-google-project-factory/tree/v18.2.0/examples/simple_project

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"
  #name                    = "obrienlabs-sandbox2-ot"
  name              = "gae-sandbox-${random_string.suffix.result}"
  random_project_id       = true

  #org_id                  = var.organization_id
  folder_id               = var.folder_id
  billing_account         = var.billing_account
  #default_service_account = "deprivilege"
  auto_create_network = false
  default_network_tier = "PREMIUM" # https://cloud.google.com/network-tiers/docs/using-network-service-tiers PREMIUM/STANDARD
  grant_services_security_admin_role = true # for GKE firewall rule creation via GKE service agent
  activate_apis        = ["appengine.googleapis.com","compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"] # may require 2nd run - wait for service enablement
  

  //labels = ["environment"]
  #activate_api_identities = [{
  #  api = "healthcare.googleapis.com"
  #  roles = [
  #    "roles/healthcare.serviceAgent",
  #    "roles/bigquery.jobUser",
  #  ]
  #}]

  deletion_policy = "DELETE"
}

module "app-engine" {
  source  = "terraform-google-modules/project-factory/google//modules/app_engine"
  version = "~> 18.0"
  project_id  = module.project-factory.project_id
  location_id = "northamerica-northeast1"
}

#  michael@cloudshell:~/wse_github/gcp-landing-zone/gcp-projects (lz-ado-xyz-boot-ot)$ gcloud services list --project obrienlabs-sandbox2-ot-ccb4 | grep NAME
#NAME: analyticshub.googleapis.com
#NAME: artifactregistry.googleapis.com
#NAME: autoscaling.googleapis.com
#NAME: bigquery.googleapis.com
#NAME: bigqueryconnection.googleapis.com
#NAME: bigquerydatapolicy.googleapis.com
#NAME: bigquerydatatransfer.googleapis.com
#NAME: bigquerymigration.googleapis.com
#NAME: bigqueryreservation.googleapis.com
#NAME: bigquerystorage.googleapis.com
#NAME: cloudbilling.googleapis.com
#NAME: compute.googleapis.com
#NAME: container.googleapis.com
#NAME: containerfilesystem.googleapis.com
#NAME: containerregistry.googleapis.com
#NAME: dataform.googleapis.com
#NAME: dataplex.googleapis.com
#NAME: dns.googleapis.com
#NAME: gkebackup.googleapis.com
#NAME: iam.googleapis.com
#NAME: iamcredentials.googleapis.com
#NAME: monitoring.googleapis.com
#NAME: networkconnectivity.googleapis.com
#NAME: oslogin.googleapis.com
#NAME: pubsub.googleapis.com
#NAME: storage-api.googleapis.com