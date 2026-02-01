output "auth_repository_url" {
  value       = aws_ecr_repository.auth.repository_url
  description = "Auth ECR repository URL"
}

output "learn_repository_url" {
  value       = aws_ecr_repository.learn.repository_url
  description = "Learn ECR repository URL"
}

output "payments_repository_url" {
  value       = aws_ecr_repository.payments.repository_url
  description = "Payments ECR repository URL"
}
