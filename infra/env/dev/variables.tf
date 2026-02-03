variable "aws_region" {
  description = "La regione AWS in cui creare le risorse"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Nome del progetto (usato nei prefissi)"
  type        = string
  default     = "teched-platform-xx" #fare con data block random
}

variable "certificate_arn" {
  description = "ARN del certificato per ALB"
  type        = string  
}