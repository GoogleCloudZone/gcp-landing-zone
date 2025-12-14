# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project.html

resource "google_project" "my_project" {
  name       = "obrienlabs-test"
  project_id = "obrienlabs-test-001"
  org_id     = "1775303217800"
}
