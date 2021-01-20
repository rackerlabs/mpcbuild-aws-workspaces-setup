output "directory_dns" {
  description = "Directory DNS"
  value = element(coalescelist(aws_directory_service_directory.simple_ad.*.dns_ip_addresses,
  aws_directory_service_directory.microsoft_ad.*.dns_ip_addresses, aws_directory_service_directory.ad_connector.*.dns_ip_addresses), 0)
}

output "directory_id" {
  description = "Directory Id"
  value = element(coalescelist(aws_directory_service_directory.simple_ad.*.id,
  aws_directory_service_directory.microsoft_ad.*.id, aws_directory_service_directory.ad_connector.*.id), 0)
}

output "directory_sg" {
  description = "Security group created for domain controllers"
  value = element(coalescelist(aws_directory_service_directory.simple_ad.*.security_group_id,
  aws_directory_service_directory.microsoft_ad.*.security_group_id, aws_directory_service_directory.ad_connector.*.security_group_id), 0)
}

output "workspace_sg" {
  description = "Workspaces designated SG"
  value       = aws_workspaces_directory.workspaces_directory.workspace_security_group_id
}
