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

variable "length_password" {
  description = "Password length of managed AWS AD. Between 8 and 64 characters"
  type        = number
  default     = 16
}

variable "create_password" {
  description = "Specify if a random password should be created by this module. If set as false, the user should provide its own password"
  type        = bool
  default     = true
}

variable "existing_password" {
  description = "Use an specific password if this required by the customer"
  type        = string
  default     = ""
}

variable "create_directory" {
  description = "Create managed AWS AD/AD Connector"
  type        = bool
  default     = true
}

variable "directory_type" {
  description = "Type of Directory to create. Options: SimpleAD, ADConnector or MicrosoftAD"
  type        = string
}

variable "directory_name" {
  description = "Directory Name (DNS name)"
  type        = string
}

variable "directory_netbios" {
  description = "Directory Netbios (short name). If not provided, Directory name will be used to generate it"
  type        = string
  default     = ""
}

variable "directory_size" {
  description = "Directory Size. If SimpleAD or AD Connector, select either Small or Large. If MicrosoftAD, select either Standard or Enterprise"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets_ids" {
  description = "Subnet ID's (2) for AD deployment. IMPORTANT NOTE: Make sure the AZ's selected are valid for the Workspaces service. More information at https://docs.aws.amazon.com/workspaces/latest/adminguide/azs-workspaces.html"
  type        = list(string)
}

variable "external_directory_username" {
  description = "Username for external AD (AD Connector Only)"
  type        = string
  default     = ""
}

variable "external_directory_password" {
  description = "Password for external AD (AD Connector Only)"
  type        = string
  default     = ""
}

variable "external_directory_dns_ips" {
  description = "List of DNS IP's on external AD (AD Connector Only)"
  type        = list(string)
  default     = []
}

variable "existing_directory_id" {
  description = "Directory ID if one is already created"
  type        = string
  default     = ""
}

variable "permission_volume_size" {
  description = "Whether WorkSpaces directory users can increase the volume size of the drives on their workspace"
  type        = bool
  default     = false
}

variable "permission_change_compute" {
  description = "Whether WorkSpaces directory users can change the compute type"
  type        = bool
  default     = false
}

variable "permission_running_mode" {
  description = "Whether WorkSpaces directory users can switch the running mode of their workspace"
  type        = bool
  default     = false
}

variable "permission_rebuild" {
  description = "Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state"
  type        = bool
  default     = false
}

variable "permission_restart" {
  description = "Whether WorkSpaces directory users can restart their workspace"
  type        = bool
  default     = true
}

variable "update_dhcp_options" {
  description = "Use AD DNS servers to resolve queries on VPC"
  type        = bool
  default     = true
}

variable "workspace_sg" {
  description = "Security Group Id to be attached to the workspaces"
  type        = string
  default     = ""
}

variable "default_ou" {
  description = "Directory OU on which the workspaces will be placed"
  type        = string
  default     = ""
}

variable "permission_internet_access" {
  description = "Whether WorkSpaces created can access the internet"
  type        = bool
  default     = false
}

variable "permission_maintenance_mode" {
  description = "Whether WorkSpaces created have automatic maintenance windows enabled"
  type        = bool
  default     = true
}

variable "permission_local_admin" {
  description = "Whether local users in WorkSpaces are admins"
  type        = bool
  default     = false
}
