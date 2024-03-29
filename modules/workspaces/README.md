# mpcbuild-aws-workspaces-setup/modules/workspaces
This module deploys 1 or more workspaces. As a pre-requisite, the Workspaces services must be associated with one AD, and the user name(s) selected must be registered on the AD. **DISCLAIMER**: Depending on the region where workspaces are deployed, it takes between 20 and 40 minutes to reach the expected state by Terraform; so take that into consideration if your intention is to deploy more than 10 workspaces using a single module execution.

## Basic Usage
```HCL
module "workspaces" {
  source           = "git@github.com:rackerlabs/mpcbuild-aws-workspaces-setup//modules/workspaces"
  username_list    = ["user1", "user2", "user2"]
  directory_id     = module.directory_workspaces.directory_id
  root_volume_size = 80
  user_volume_size = 50
  tags             = local.tags
}
```  
**NOTE**: AD management is not on the scope of FAWS. The proper creation of AD users, AD OU's and any AD configuration relies completely on the customer

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.22.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| auto\_stop\_timeout | Time in muntes to wait before stopping the workspace | `number` | `60` | no |
| bundle\_id | Specific bundle Id, in case a selection is already known or if a custom bundle is needed | `string` | `""` | no |
| directory\_id | Directory Id that will be associated to the workspaces. Can be SimpleAD, Managed AD or AD Connector | `string` | n/a | yes |
| enable\_encryption | Flag to define if encryption should be enabled on the volumes attached to the workspaces | `bool` | `false` | no |
| environment | Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test. | `string` | `"Development"` | no |
| key\_identifier | KMS key used to encrypt the volumes. Use the key id or the full ARN. NOTE: Since Terraform has a limitation using key alias that forces replacement, avoid using it | `string` | `""` | no |
| root\_volume\_size | Size in GB of the root volume | `number` | n/a | yes |
| running\_mode | Running mode selected for the workspaces. Can be AUTO\_STOP or ALWAYS\_ON | `string` | `"AUTO_STOP"` | no |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| user\_volume\_size | Size in GB of the user volume | `number` | n/a | yes |
| username\_list | List of users to be created. Make sure these users are already created on the selected AD and they have an email registered | `list(string)` | n/a | yes |
| workspace\_bundle | Bundle (combination of OS + applications) to deploy on the workspaces. The following are the valid options: Windows 10 (Server 2019 based), Windows 10 and Office 2019 Pro Plus (Server 2019 based), Windows 10 and Office 2016 Pro Plus (Server 2016 based), Amazon Linux 2, Windows 7, Windows 7 and Office 2010 | `string` | `"Windows 10 (Server 2019 based)"` | no |
| workspace\_compute\_type | Compute type required for the workspaces. The following are the valid options: Performance, Standard, PowerPro, Power, Value, Graphics, GraphicsPro | `string` | `"Standard"` | no |

## Outputs

No output.

