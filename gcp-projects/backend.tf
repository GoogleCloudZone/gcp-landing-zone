
terraform {
  backend "gcs" {
    bucket = "gcp-bootstrap-state"
    prefix = "terraform/gcp-landing-zone/gcp-projects/state"
  }
}
