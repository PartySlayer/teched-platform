variable "project_name" {
  description = "Nome del progetto (usato nei prefissi)"
  default     = "teched-platform-xx" #fare con data block random
}

variable "enable_container_insights" {
  description = "Abilita CloudWatch Container Insights"
  type        = bool
  default     = true
}
