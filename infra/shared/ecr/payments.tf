resource "aws_ecr_repository" "payments" {
  name                 = "${var.project_name}/payments"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
