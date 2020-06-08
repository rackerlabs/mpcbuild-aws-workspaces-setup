provider "aws" {
  region = "us-west-2"
}

#This example is to create an EC2 instance that will be used to enable MFA functionality with AD manage service
#This example uses a Ansible playbook to deploy FreeRadius package and configuration on 1 Amazon2 EC2 instance
#Along with FreeRadius, Google authenticator libraries and binaries are also deployed.
#The YAML file with the playbook should be uploaded on a S3 bucket selected by the build engineer.
##IMPORTANT NOTE 1: Enabling MFA on a directory is currently not available in Terraform.
##The API EnableRadius is already available in AWS, so the operation can be done through the Console or CLI
##IMPORTANT NOTE 2: The FreeRadius implementation is only for demo purposes and cannot be considered a solution for production
##If the customer requires a production-ready solution, they must search a 3rd party provider with mature solutions

resource "random_string" "shared_secret" {
    length = 30
    special = false
}

resource "aws_ssm_parameter" "radius_secret_ssm" {
  name  = "${var.environment}-radius_secret"
  type  = "SecureString"
  value = random_string.shared_secret.result

  lifecycle {
    ignore_changes = all
  }
}

module "ec2_ar_radius" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-ec2_autorecovery?ref=v0.12.7"

  backup_tag_value                  = "False"
  ec2_os                            = "amazon2"
  instance_count                    = 1
  instance_type                     = "t2.micro"
  key_pair                          = "windows"
  name                              = "ansible-mfa-test"
  primary_ebs_volume_iops           = 0
  primary_ebs_volume_size           = 20
  primary_ebs_volume_type           = "gp2"
  security_groups                   = [var.radius_sg]
  subnets                           = [module.vpc.private_subnets.0]
  tenancy                           = "default"
  instance_role_managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  ssm_bootstrap_list = [
    {
      action = "aws:runDocument",
      inputs = {
        documentPath = "AWS-ApplyAnsiblePlaybooks",
        documentParameters = {
          SourceType = "S3"
          SourceInfo = jsonencode(
            {
              "path" : "https://s3.amazonaws.com/${var.s3_bucket}/radius.yaml"
            }
          )
          InstallDependencies = "True"
          PlaybookFile        = "radius.yaml"
          ExtraVariables      = "SSM=True vpc_cidr=${var.vpc_cidr} shared_secret=${random_string.shared_secret.result}"
          Check               = "False"
          Verbose             = "-vv"
        },
        documentType = "SSMDocument"
      },
      name           = "AnsibleRadiusPlaybook",
      timeoutSeconds = 300
    }
  ]
}
