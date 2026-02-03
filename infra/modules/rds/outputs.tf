output "endpoint" {
  value = aws_db_instance.this.endpoint
}

output "port" {
  value = aws_db_instance.this.port
}

output "security_group_id" {
  value = aws_security_group.rds.id
}

output "username" {
  value = aws_db_instance.this.username
}

output "password" {
  value     = random_password.db.result
  sensitive = true
}
