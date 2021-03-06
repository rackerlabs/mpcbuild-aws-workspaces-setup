# mpcbuild-aws-workspaces-setup/modules/directory
This module deploys a AWS Directory service and the proper integration with Workspaces. If the directory is already created, it only creates the association with the Workspaces service

## Basic Usage
```HCL
module "directory_workspaces" {
  source         = "git@github.com:rackerlabs/mpcbuild-aws-workspaces-setup//modules/directory"
  directory_type = "SimpleAD"
  directory_name = "aws.directory.test"
  directory_size = "Small"
  vpc_id         = module.base_network.vpc_id
  subnets_ids    = module.vpc.private_subnets 
}
```  
**NOTE**: This module doesn't deploy workspaces. This operation should be done once the users are created on the selected Active Directory. Please refer to the module specific for workspaces

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.21.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| create\_directory | Create managed AWS AD/AD Connector | `bool` | `true` | no |
| create\_password | Specify if a random password should be created by this module. If set as false, the user should provide its own password | `bool` | `true` | no |
| default\_ou | Directory OU on which the workspaces will be placed | `string` | `""` | no |
| directory\_name | Directory Name (DNS name) | `string` | n/a | yes |
| directory\_netbios | Directory Netbios (short name). If not provided, Directory name will be used to generate it | `string` | `""` | no |
| directory\_size | Directory Size. If SimpleAD or AD Connector, select either Small or Large. If MicrosoftAD, select either Standard or Enterprise | `string` | n/a | yes |
| directory\_type | Type of Directory to create. Options: SimpleAD, ADConnector or MicrosoftAD | `string` | n/a | yes |
| environment | Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test. | `string` | `"Development"` | no |
| existing\_directory\_id | Directory ID if one is already created | `string` | `""` | no |
| existing\_password | Use an specific password if this required by the customer | `string` | `""` | no |
| external\_directory\_dns\_ips | List of DNS IP's on external AD (AD Connector Only) | `list(string)` | `[]` | no |
| external\_directory\_password | Password for external AD (AD Connector Only) | `string` | `""` | no |
| external\_directory\_username | Username for external AD (AD Connector Only) | `string` | `""` | no |
| length\_password | Password length of managed AWS AD. Between 8 and 64 characters | `number` | `16` | no |
| permission\_change\_compute | Whether WorkSpaces directory users can change the compute type | `bool` | `false` | no |
| permission\_internet\_access | Whether WorkSpaces created can access the internet | `bool` | `false` | no |
| permission\_local\_admin | Whether local users in WorkSpaces are admins | `bool` | `false` | no |
| permission\_maintenance\_mode | Whether WorkSpaces created have automatic maintenance windows enabled | `bool` | `true` | no |
| permission\_rebuild | Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state | `bool` | `false` | no |
| permission\_restart | Whether WorkSpaces directory users can restart their workspace | `bool` | `true` | no |
| permission\_running\_mode | Whether WorkSpaces directory users can switch the running mode of their workspace | `bool` | `false` | no |
| permission\_volume\_size | Whether WorkSpaces directory users can increase the volume size of the drives on their workspace | `bool` | `false` | no |
| subnets\_ids | Subnet ID's (2) for AD deployment. IMPORTANT NOTE: Make sure the AZ's selected are valid for the Workspaces service. More information at https://docs.aws.amazon.com/workspaces/latest/adminguide/azs-workspaces.html | `list(string)` | n/a | yes |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| update\_dhcp\_options | Use AD DNS servers to resolve queries on VPC | `bool` | `true` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |
| workspace\_sg | Security Group Id to be attached to the workspaces | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| directory\_dns | Directory DNS |
| directory\_id | Directory Id |
| directory\_sg | Security group created for domain controllers |
| workspace\_sg | Workspaces designated SG |

