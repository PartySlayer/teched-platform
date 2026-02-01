output "github_role_arn" {
  value       = aws_iam_role.github_actions_role.arn
  description = "L'ARN da incollare nel file YAML della GitHub Action"
}
