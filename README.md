# mpcbuild-aws-workspaces

This repository contain 3 module to deploy the various services needed for Workspaces creation.

## Module listing
- [directory](./modules/directory/) - Terraform module to deploy directory services and the association with Workspaces
- [iam](./modules/iam/) - Terraform module to deploy IAM role neccessary for Workspaces 
- [workspaces](./modules/workspaces/) - Terraform module to deploy the workspaces