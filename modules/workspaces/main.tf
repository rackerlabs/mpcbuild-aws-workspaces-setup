terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 3.22.0"
  }
}

locals {
  tags = {
    Environment     = var.environment
    ServiceProvider = "Rackspace"
  }
}

####### Get bundle Id #######

data "aws_workspaces_bundle" "bundle" {
  owner = "AMAZON"
  name  = "${var.workspace_compute_type} with ${var.workspace_bundle}"
}

###### Workspaces #######

resource "aws_workspaces_workspace" "workspaces" {
  for_each = toset(var.username_list)

  user_name                      = each.key
  directory_id                   = var.directory_id
  bundle_id                      = var.bundle_id == "" ? data.aws_workspaces_bundle.bundle.id : var.bundle_id
  root_volume_encryption_enabled = var.enable_encryption
  user_volume_encryption_enabled = var.enable_encryption
  volume_encryption_key          = var.enable_encryption ? var.key_identifier : null
  tags                           = var.tags

  workspace_properties {
    compute_type_name                         = upper(var.workspace_compute_type)
    user_volume_size_gib                      = var.user_volume_size
    root_volume_size_gib                      = var.root_volume_size
    running_mode                              = var.running_mode
    running_mode_auto_stop_timeout_in_minutes = var.running_mode == "AUTO_STOP" ? var.auto_stop_timeout : null
  }

  timeouts {
    create = "45m"
  }
}
