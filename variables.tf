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
  description = "Subnet ID's (2) for AD deployment"
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
variable "create_windows_instance" {
  description = "Create Windows Server Instance to manage Active Directory"
  type        = bool
  default     = true
}
