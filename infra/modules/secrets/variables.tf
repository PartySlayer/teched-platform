variable "environment" {
  type = string
}

variable "project_name" {
  type = string
  description = "Nome del progetto (usato nei prefissi)"
  default     = "teched-platform-xx" #fare con data block random
}

variable "auth_db_url" {
  type = string
  sensitive = true
}

variable "learn_db_url" {
  type = string
  sensitive = true
}

variable "stripe_secret_key" {
  type = string
  sensitive = true
}

variable "stripe_webhook_secret" {
  type = string
  sensitive = true
}
