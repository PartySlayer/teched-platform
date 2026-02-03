variable "project_name" {
  description = "Nome del progetto (usato nei prefissi)"
  default     = "teched-platform-xx" #fare con data block random
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs"
}

variable "db_name" {
  type    = string
}

variable "engine_version" {
  type    = string
  default = "15.10"
}

variable "instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "backup_retention_period" {
  type    = number
  default = 0
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "allowed_security_group_ids" {
  type        = list(string)
  description = "ECS service SGs allowed to access DB"
}

variable "db_identifier" {
  description = "Identificatore per ogni istanza RDS Postgres"
  type = string
  
}