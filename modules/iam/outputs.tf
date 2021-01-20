output "iam_role_arn" {
  description = "ARN of the AWS Workspaces role."
  value       = aws_iam_role.workspace_role.arn
}

output "iam_role_name" {
  description = "Name of the AWS Workspaces role."
  value       = aws_iam_role.workspace_role.name
}