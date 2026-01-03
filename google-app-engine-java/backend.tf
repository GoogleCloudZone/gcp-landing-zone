
terraform {
  backend "gcs" {
    bucket = "gcp-archetypes-state"
    prefix = "terraform/gcp-archetypes/google-app-engine-java/state"
  }
}
