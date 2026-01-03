
output "project_id" {
  value       = module.project-factory.project_id
  description = "The ID of the created project"
}

output "vpc" {
  value       = module.vpc
  description = "The network info"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets" {
  value       = module.vpc.subnets_self_links
  description = "The shared VPC subets"
}

output "app_name" {
  description = "Unique name of the app, usually apps/{PROJECT_ID}."
  value       = module.app-engine.name
}

output "default_hostname" {
  description = "The default hostname for this app."
  value       = module.app-engine.default_hostname
}

output "location_id" {
  description = "The location app engine is serving from"
  value       = module.app-engine.location_id
}