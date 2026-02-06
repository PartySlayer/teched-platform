output "auth_secret_arn" {
  value = aws_secretsmanager_secret.auth.arn
}

output "learn_secret_arn" {
  value = aws_secretsmanager_secret.learn.arn
}

output "payments_secret_arn" {
  value = aws_secretsmanager_secret.payments.arn
}
