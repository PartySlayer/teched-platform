locals {
  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "auth" {
  repository = aws_ecr_repository.auth.name
  policy     = local.lifecycle_policy
}

resource "aws_ecr_lifecycle_policy" "learn" {
  repository = aws_ecr_repository.learn.name
  policy     = local.lifecycle_policy
}

resource "aws_ecr_lifecycle_policy" "payments" {
  repository = aws_ecr_repository.payments.name
  policy     = local.lifecycle_policy
}
