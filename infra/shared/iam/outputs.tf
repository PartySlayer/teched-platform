output "github_role_arn" {
  value       = aws_iam_role.github_actions_role.arn
  description = "L'ARN da incollare nel file YAML della GitHub Action"
}

output "auth_task_role_arn" {
  value = aws_iam_role.auth_task_role.arn
  description = "L'ARN del ruolo attribuito al task del servizio Auth"
}

output "learn_task_role_arn" {
  value = aws_iam_role.learn_task_role.arn
  description = "L'ARN del ruolo attribuito al task del servizio Learn"
}

output "payments_task_role_arn" {
  value = aws_iam_role.payments_task_role.arn
  description = "L'ARN del ruolo attribuito al task del servizio Payments"
}