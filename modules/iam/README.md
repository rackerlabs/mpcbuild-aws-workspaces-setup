# mpcbuild-aws-workspaces-setup/modules/iam
This module deploys the proper IAM service role for the Workspaces services with the required managed policies

## Basic Usage
```HCL
module "iam_workspaces" {
  source         = "git@github.com:rackerlabs/mpcbuild-aws-workspaces-setup//modules/iam"
}
```  

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.70.0 |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | ARN of the AWS Workspaces role. |
| iam\_role\_name | Name of the AWS Workspaces role. |

