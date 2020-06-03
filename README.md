## Providers

| Name | Version |
|------|---------|
| aws | >= 2.64.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| create\_directory | Create managed AWS AD/AD Connector | `bool` | `true` | no |
| create\_windows\_instance | Create Windows Server Instance to manage Active Directory | `bool` | `true` | no |
| directory\_name | Directory Name (DNS name) | `string` | n/a | yes |
| directory\_netbios | Directory Netbios (short name). If not provided, Directory name will be used to generate it | `string` | `""` | no |
| directory\_size | Directory Size. If SimpleAD or AD Connector, select either Small or Large. If MicrosoftAD, select either Standard or Enterprise | `string` | n/a | yes |
| directory\_type | Type of Directory to create. Options: SimpleAD, ADConnector or MicrosoftAD | `string` | n/a | yes |
| environment | Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test. | `string` | `"Development"` | no |
| existing\_directory\_id | Directory ID if one is already created | `string` | `""` | no |
| external\_directory\_dns\_ips | List of DNS IP's on external AD (AD Connector Only) | `list(string)` | `[]` | no |
| external\_directory\_password | Password for external AD (AD Connector Only) | `string` | `""` | no |
| external\_directory\_username | Username for external AD (AD Connector Only) | `string` | `""` | no |
| length\_password | Password length of managed AWS AD. Between 8 and 64 characters | `number` | `16` | no |
| permission\_change\_compute | Whether WorkSpaces directory users can change the compute type | `bool` | `false` | no |
| permission\_rebuild | Whether WorkSpaces directory users can rebuild the operating system of a workspace to its original state | `bool` | `false` | no |
| permission\_restart | Whether WorkSpaces directory users can restart their workspace | `bool` | `true` | no |
| permission\_running\_mode | Whether WorkSpaces directory users can switch the running mode of their workspace | `bool` | `false` | no |
| permission\_volume\_size | Whether WorkSpaces directory users can increase the volume size of the drives on their workspace | `bool` | `false` | no |
| subnets\_ids | Subnet ID's (2) for AD deployment | `list(string)` | n/a | yes |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| directory\_dns | Directory DNS |
| directory\_id | Directory Id |
| directory\_sg | Security group created for domain controllers |
| workspace\_sg | Workspaces designated SG |

