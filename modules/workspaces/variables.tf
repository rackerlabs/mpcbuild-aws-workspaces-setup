variable "directory_id" {
  description = "Directory Id that will be associated to the workspaces. Can be SimpleAD, Managed AD or AD Connector"
  type        = string
}

variable "enable_encryption" {
  description = "Flag to define if encryption should be enabled on the volumes attached to the workspaces"
  type        = bool
  default     = false
}

variable "key_identifier" {
  description = "KMS key used to encrypt the volumes. Use the key id or the full ARN. NOTE: Since Terraform has a limitation using key alias that forces replacement, avoid using it"
  type        = string
  default     = ""
}

variable "username_list" {
  description = "List of users to be created. Make sure these users are already created on the selected AD and they have an email registered"
  type        = list(string)
}

variable "tags" {
  description = "Custom tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test."
  type        = string
  default     = "Development"
}

variable "workspace_compute_type" {
  description = "Compute type required for the workspaces. The following are the valid options: Performance, Standard, PowerPro, Power, Value, Graphics, GraphicsPro"
  type        = string
  default     = "Standard"
}

variable "workspace_bundle" {
  description = "Bundle (combination of OS + applications) to deploy on the workspaces. The following are the valid options: Windows 10 (Server 2019 based), Windows 10 and Office 2019 Pro Plus (Server 2019 based), Windows 10 and Office 2016 Pro Plus (Server 2016 based), Amazon Linux 2, Windows 7, Windows 7 and Office 2010"
  type        = string
  default     = "Windows 10 (Server 2019 based)"
}

variable "bundle_id" {
  description = "Specific bundle Id, in case a selection is already known or if a custom bundle is needed"
  type        = string
  default     = ""
}

variable "running_mode" {
  description = "Running mode selected for the workspaces. Can be AUTO_STOP or ALWAYS_ON"
  type        = string
  default     = "AUTO_STOP"
}

variable "user_volume_size" {
  description = "Size in GB of the user volume"
  type        = number
}

variable "root_volume_size" {
  description = "Size in GB of the root volume"
  type        = number
}

variable "auto_stop_timeout" {
  description = "Time in muntes to wait before stopping the workspace"
  type        = number
  default     = 60
}
