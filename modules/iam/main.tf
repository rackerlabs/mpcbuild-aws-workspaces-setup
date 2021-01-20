terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.70.0"
  }
}

data "aws_iam_policy_document" "workspace_assume_role_policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = ["workspaces.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "workspace_role" {
  assume_role_policy = data.aws_iam_policy_document.workspace_assume_role_policy_doc.json
  name               = "workspaces_DefaultRole"
  path               = "/"
}

resource "aws_iam_role_policy_attachment" "attach_workspace_policy_1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess"
  role       = aws_iam_role.workspace_role.name
}

resource "aws_iam_role_policy_attachment" "attach_workspace_policy_2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesSelfServiceAccess"
  role       = aws_iam_role.workspace_role.name
}