# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project.html

#resource "google_project" "my_project" {
#  name       = "obrienlabs-test"
#  project_id = "obrienlabs-test-001"
#  org_id     = "1775303217800"
#}

# https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest
# https://github.com/terraform-google-modules/terraform-google-project-factory/tree/v18.2.0/examples/simple_project

module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"

  random_project_id       = true
  name                    = "simple-sample-project"
  org_id                  = var.organization_id
  billing_account         = var.billing_account
  default_service_account = "deprivilege"

  activate_api_identities = [{
    api = "healthcare.googleapis.com"
    roles = [
      "roles/healthcare.serviceAgent",
      "roles/bigquery.jobUser",
    ]
  }]

  deletion_policy = "DELETE"
}

output "project_info_example" {
  value       = module.project-factory.project_id
  description = "The ID of the created project"
}

output "domain_example" {
  value       = module.project-factory.domain
  description = "The organization's domain"
}

