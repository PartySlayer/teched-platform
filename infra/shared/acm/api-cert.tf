resource "aws_acm_certificate" "api" {
  domain_name               = var.domain_name
  subject_alternative_names = [
    "*.${var.domain_name}"
  ]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

}
