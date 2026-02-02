output "api_certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate.api.arn
}

output "cloudfront_certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate.cloudfront.arn
}

output "domain_name" {
  value = var.domain_name
}


