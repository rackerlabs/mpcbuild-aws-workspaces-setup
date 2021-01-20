output "workspaces_id_list" {
  description = "List of IDs for the workspaces"
  value       = aws_workspaces_workspace.workspaces.*.id
}
