variable "project_name" {
  description = "Nome del progetto (usato nei prefissi)"
  default     = "teched-platform-xx" #fare con data block random
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN"
}

variable "health_check_path" {
  type    = string
  default = "/health"
}
