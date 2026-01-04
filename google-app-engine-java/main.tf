# prereq
# on boot project enable
# App Engine Admin API appengine.googleapis.com
# Compute API compute.googleapis.com

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project.html


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
  deletion_policy = "DELETE"
}

# https://github.com/terraform-google-modules/terraform-google-project-factory/blob/v18.2.0/examples/app_engine/main.tf

module "app-engine" {
  source  = "terraform-google-modules/project-factory/google//modules/app_engine"
  version = "~> 18.0"
  project_id  = module.project-factory.project_id
  location_id = var.region
}


#resource "time_sleep" "wait_for_apis" {
#  depends_on      = [project-factory.activate_apis]
#  create_duration = "60s"
#}

# local for now - later in cicd project
resource "google_artifact_registry_repository" "images" {
  project       = module.project-factory.project_id
  location      = var.region
  repository_id = var.artifact_repo_id
  format        = "DOCKER"
  description   = "Docker images for GAE services"
  #depends_on = [time_sleep.wait_for_apis]
}

#locals {
#  cloudbuild_sa = "${google_project.app.number}@cloudbuild.gserviceaccount.com"
#}

#resource "google_project_iam_member" "cloudbuild_ar_writer" {
#  project = google_project.app.project_id
#  role    = "roles/artifactregistry.writer"
#  member  = "serviceAccount:${local.cloudbuild_sa}"
#  depends_on = [time_sleep.wait_for_apis]
#}

# Ensure the service agent exists, and grant it AR read (so gae can pull the image).
# gae-sandbox-3z8g-8f97@appspot.gserviceaccount.com
#resource "google_project_service_identity" "gae_service_identity" {
#  provider = google-beta
#  project  = module.project-factory.project_id
#  service  = "appengine.googleapis.com"
#  #epends_on = [time_sleep.wait_for_apis]
#}

# 
#resource "google_project_iam_member" "gae_artifact_reader" {
#  project = module.project-factory.project_id
#  role    = "roles/artifactregistry.reader"
#  #member  = "serviceAccount:${google_project_service_identity.gae_service_identity.email}"
#  #"serviceAccount:project-service-account@gae-sandbox-3z8g-8f97.iam.gserviceaccount.com"
#  # from terraform show
#  member = module.app-engine.default_service_account
#  depends_on = [google_artifact_registry_repository.images]
#}


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