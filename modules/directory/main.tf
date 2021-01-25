terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 3.21.0"
  }
}

locals {
  tags = {
    Environment     = var.environment
    ServiceProvider = "Rackspace"
  }
}

######## Create Password and store it on SSM #######

resource "random_string" "ad_password" {
  count = var.create_password ? 1 : 0

  length           = var.length_password
  override_special = "!@#$%&()-_"
}

resource "aws_ssm_parameter" "ad_password_ssm" {
  count = var.create_directory && var.directory_type != "ADConnector" && var.create_password ? 1 : 0

  name  = "${var.environment}-ad-password"
  type  = "SecureString"
  value = random_string.ad_password.0.result

  lifecycle {
    ignore_changes = all
  }
}

####### Create SimpleAD directory if selected #######

resource "aws_directory_service_directory" "simple_ad" {
  count = var.create_directory && var.directory_type == "SimpleAD" ? 1 : 0

  type       = var.directory_type
  name       = var.directory_name
  short_name = var.directory_netbios != "" ? var.directory_netbios : null
  password   = var.create_password ? random_string.ad_password.0.result : var.existing_password
  size       = var.directory_size

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnets_ids
  }

  tags = merge(var.tags, local.tags)
}

####### Create AWS Managed Microsoft AD

resource "aws_directory_service_directory" "microsoft_ad" {
  count = var.create_directory && var.directory_type == "MicrosoftAD" ? 1 : 0

  type       = var.directory_type
  name       = var.directory_name
  short_name = var.directory_netbios != "" ? var.directory_netbios : null
  password   = var.create_password ? random_string.ad_password.0.result : var.existing_password
  edition    = var.directory_size

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnets_ids
  }

  tags = merge(var.tags, local.tags)
}

resource "aws_directory_service_directory" "ad_connector" {
  count = var.create_directory && var.directory_type == "ADConnector" ? 1 : 0

  type       = var.directory_type
  name       = var.directory_name
  short_name = var.directory_netbios != "" ? var.directory_netbios : null
  password   = var.external_directory_password
  size       = var.directory_size

  connect_settings {
    customer_dns_ips  = var.external_directory_dns_ips
    customer_username = var.external_directory_username
    vpc_id            = var.vpc_id
    subnet_ids        = var.subnets_ids
  }

  tags = merge(var.tags, local.tags)
}

resource "aws_vpc_dhcp_options" "dhcp_options_ad" {
  count = var.create_directory ? 1 : 0
  domain_name_servers = element(coalescelist(aws_directory_service_directory.simple_ad.*.dns_ip_addresses,
  aws_directory_service_directory.microsoft_ad.*.dns_ip_addresses, aws_directory_service_directory.ad_connector.*.dns_ip_addresses), 0)
  domain_name = var.directory_name
}

resource "aws_vpc_dhcp_options_association" "dns_resolver_ad" {
  count           = var.create_directory && var.update_dhcp_options ? 1 : 0
  vpc_id          = var.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options_ad.0.id
}

resource "aws_workspaces_directory" "workspaces_directory" {
  directory_id = element(coalescelist(aws_directory_service_directory.simple_ad.*.id,
    aws_directory_service_directory.microsoft_ad.*.id, aws_directory_service_directory.ad_connector.*.id,
  [var.existing_directory_id]), 0)

  self_service_permissions {
    increase_volume_size = var.permission_volume_size
    rebuild_workspace    = var.permission_rebuild
    change_compute_type  = var.permission_change_compute
    switch_running_mode  = var.permission_running_mode
    restart_workspace    = var.permission_restart
  }

  workspace_creation_properties {
    custom_security_group_id            = var.workspace_sg != "" ? var.workspace_sg : null
    default_ou                          = var.default_ou != "" ? var.default_ou : null
    enable_internet_access              = var.permission_internet_access
    enable_maintenance_mode             = var.permission_maintenance_mode
    user_enabled_as_local_administrator = var.permission_local_admin
  }

  tags = merge(var.tags, local.tags)
}
