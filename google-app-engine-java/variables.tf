variable "organization_id" {
  description = "The organization id for the associated services"
}

variable "folder_id" {
  description = "The folder id for the associated services"
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
}

variable "network_name" {
  description = "Name for Shared VPC network"
  default     = "shared-network"
}

variable "region" {
  description = "region"
  default     = "northamerica-northeast1"
}

variable "artifact_repo_id" {
  description = "Artifact Registry repository id (DOCKER format)."
  type        = string
  default     = "gae-images"
}

variable "disable_services_on_destroy" {
  description = "If true, APIs will be disabled when Terraform destroys the google_project_service resources."
  type        = bool
  default     = false
}