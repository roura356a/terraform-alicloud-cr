output "cr_user_id" {
  description = "The CR Namespace's User ID"
  value       = alicloud_ram_user.namespace_user.id
}

output "cr_user_name" {
  description = "The CR Namespace's User Name"
  value       = alicloud_ram_user.namespace_user.name
}

output "cr_user_key" {
  description = "The CR Namespace's User access key ID"
  value       = alicloud_ram_access_key.cr_ak.id
}

output "repository_ids" {
  description = "List of repository IDs created"
  value       = length(var.repositories) > 0 ? alicloud_cr_repo.namespace_repositories.*.id : null
}

output "repository_host" {
  description = "Domain of public endpoint"
  value       = length(var.repositories) > 0 ? alicloud_cr_repo.namespace_repositories[0].domain_list.public : null
}
