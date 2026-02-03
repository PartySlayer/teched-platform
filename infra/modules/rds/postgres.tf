resource "random_password" "db" {
  length  = 32
  special = true
}

resource "aws_db_instance" "this" {
  identifier = var.db_identifier

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  username = "app"
  password = random_password.db.result
  db_name  = var.db_name
  multi_az = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  storage_encrypted = true

  skip_final_snapshot = false
  final_snapshot_identifier = "${var.project_name}-final"

  deletion_protection = false

  performance_insights_enabled = true
  monitoring_interval          = 0

}
