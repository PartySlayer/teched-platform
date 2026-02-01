variable "project_name" {
  description = "Nome del progetto (usato nei prefissi)"
  default     = "teched-platform-xx" #fare con data block random
}

variable "aws_region" {
  description = "La regione AWS in cui creare le risorse"
  type        = string
  default     = "eu-west-1"
}

variable "terraform_state_bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform remote state"
}

variable "terraform_locks_table_name" {
  type        = string
  description = "DynamoDB table name for Terraform state locking"
}