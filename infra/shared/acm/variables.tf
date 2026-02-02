variable "aws_region" {
  description = "La regione AWS in cui creare il certificato ACM"
  type        = string
  default     = "eu-west-1"
}

variable "domain_name" {
  description = "Il dominio"
  type        = string
  default     = "teched-platform.xyz"
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}
