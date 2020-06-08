provider "aws" {
  region = "us-west-2"
}

#This example is to create an EC2 that will be used to manage AD groups, users inside the manage AD created
#The pre-requisite is to have an EC2 instance joined to the proper AD domain
#To do so, a new SSM bootstrap instruction is added to the default ones managed by the module
##NOTE: This example is only to highlight the parameters that could be used as input on EC2 module from AD module.
##In reality, AD module would be in a different layer from the EC2 module

module "ec2_ar_windowsad" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-ec2_autorecovery?ref=v0.12.7"

  backup_tag_value               = "False"
  ec2_os                         = "windows2019"
  instance_count                 = 1
  instance_type                  = var.instance_type
  key_pair                       = var.key_pair
  name                           = "windowsad-test"
  primary_ebs_volume_iops        = 0
  primary_ebs_volume_size        = 30
  primary_ebs_volume_type        = "gp2"
  security_groups                = [var.sg_ad]
  subnets                        = [module.vpc.private_subnets.0]
  tenancy                        = "default"
  environment                    = var.environment
  final_userdata_commands        = "Install-WindowsFeature -Name GPMC,RSAT-AD-PowerShell,RSAT-AD-AdminCenter,RSAT-ADDS-Tools,RSAT-DNS-Server"

  ssm_bootstrap_list = [
    {
      action = "aws:runDocument",
      inputs = {
        documentPath = "AWS-JoinDirectoryServiceDomain",
        documentParameters = {
          directoryId = module.directory.directory_id
          directoryName = "test.build.local"
          dnsIpAddresses = module.directory.directory_dns
        },
        documentType = "SSMDocument"
      },
      name           = "WindowsJoinDomainAD",
      timeoutSeconds = 300
    }
  ]
}


module "directory" {
  source = "git@github.com:rackerlabs/mpcbuild-aws-workspaces-setup//?ref=v0.12.0"

  directory_type = "SimpleAD"
  directory_name = "test.build.local"
  directory_netbios = "test"
  directory_size = "Small"
  vpc_id = module.base_network.vpc_id
  subnets_ids = module.vpc.private_subnets
}
