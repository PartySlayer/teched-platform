resource "aws_secretsmanager_secret" "auth" {
  name = "${var.project_name}/${var.environment}/auth"
}

resource "aws_secretsmanager_secret_version" "auth" {
  secret_id = aws_secretsmanager_secret.auth.id

  secret_string = jsonencode({
    JWT_SECRET = random_password.jwt.result
    DATABASE_URL = var.auth_db_url
  })
}

resource "aws_secretsmanager_secret" "learn" {
  name = "${var.project_name}/${var.environment}/learn"
}

resource "aws_secretsmanager_secret_version" "learn" {
  secret_id = aws_secretsmanager_secret.learn.id

  secret_string = jsonencode({
    DATABASE_URL = var.learn_db_url
    SERVICE_TOKEN = random_password.service_token.result
  })
}

resource "aws_secretsmanager_secret" "payments" {
  name = "${var.project_name}/${var.environment}/payments"
}

resource "aws_secretsmanager_secret_version" "payments" {
  secret_id = aws_secretsmanager_secret.payments.id

  secret_string = jsonencode({
    STRIPE_SECRET_KEY = var.stripe_secret_key
    STRIPE_WEBHOOK_SECRET = var.stripe_webhook_secret
    SERVICE_TOKEN = random_password.service_token.result
  })
}

resource "random_password" "jwt" {
  length  = 64
  special = true
}

resource "random_password" "service_token" {
  length  = 32
  special = false
}
