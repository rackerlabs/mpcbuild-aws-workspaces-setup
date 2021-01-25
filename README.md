# mpcbuild-aws-workspaces

This repository contain 3 module to deploy the various services needed for Workspaces creation.

## Module listing
- [iam](./modules/iam/) - Terraform module to deploy IAM role neccessary for Workspaces. Mandatory step to work with the other 2 modules
- [directory](./modules/directory/) - Terraform module to deploy directory services and the association with Workspaces
- [workspaces](./modules/workspaces/) - Terraform module to deploy the workspaces