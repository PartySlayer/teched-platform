data "aws_s3_bucket" "terraform_state" {
  bucket = var.terraform_state_bucket_name
}

data "aws_dynamodb_table" "terraform_locks" {
  name = var.terraform_locks_table_name
}

# Github Actions CI/CD role for terraform
resource "aws_iam_role_policy" "terraform_permissions" {
  name = "terraform-deploy-policy"
  role = aws_iam_role.github_actions_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # Permessi precisi per la gestione dello stato
      {
        Sid    = "TerraformStateAccess"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          data.aws_s3_bucket.terraform_state.arn,
          "${data.aws_s3_bucket.terraform_state.arn}/*",
          data.aws_dynamodb_table.terraform_locks.arn
        ]
      },

      # Permessi di sola lettura per terraform plan
      {
        Sid    = "ReadOnlyGlobal"
        Effect = "Allow"
        Action = [
          "ecs:Describe*", "ecs:List*",
          "rds:Describe*",
          "elasticloadbalancing:Describe*",
          "apigateway:GET",
          "iam:Get*", "iam:List*",
          "secretsmanager:Describe*", "secretsmanager:ListSecrets",
          "cloudfront:List*",
          "acm:Describe*", "acm:ListCertificates"
        ]
        Resource = "*"
      },

      # Modifiche distruttive "*", con prefisso
      {
        Sid    = "WriteScopedResources"
        Effect = "Allow"
        Action = [

          "ecs:*",
          "rds:*",
          "secretsmanager:*",
          "elasticloadbalancing:*",
          "apigateway:*",
          "s3:*",
          "cloudfront:*",
          "acm:*"

        ]
        Resource = [

          # ECS
          "arn:aws:ecs:*:*:cluster/teched-*",
          "arn:aws:ecs:*:*:task-definition/teched-*",
          "arn:aws:ecs:*:*:service/*/teched-*",

          # RDS
          "arn:aws:rds:*:*:db:teched-*",
          "arn:aws:rds:*:*:snapshot:teched-*",
          "arn:aws:rds:*:*:subgrp:teched-*",

          # Secrets Manager
          "arn:aws:secretsmanager:*:*:secret:teched-*",

          # S3
          "arn:aws:s3:::teched-*",
          "arn:aws:s3:::teched-*/*",

          # CloudFront ("distribution/*" permette tutto, in caso vanno messi tags e chiuso lo scope.
          "arn:aws:cloudfront::*:distribution/*",

          # ALB / ELB arn:aws:elasticloadbalancing:region:account:loadbalancer/app/nome/id
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/*",
          "arn:aws:elasticloadbalancing:*:*:targetgroup/*",

          # ACM
          "arn:aws:acm:*:*:certificate/*"
        ]
      },

      # IAM scritto in modo puntuale perché "*" è pericoloso
      {
        Sid    = "IAMScopedManagement"
        Effect = "Allow"
        Action = [
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:UpdateRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:TagRole"
        ]
        Resource = [
          "arn:aws:iam::*:role/teched-*",
          "arn:aws:iam::*:policy/teched-*"
        ]
      },

      # PassRole ha bisogno di autorizzazione esplicita sulla risorsa
      {
        Sid      = "PassRole"
        Effect   = "Allow"
        Action   = "iam:PassRole"
        Resource = "arn:aws:iam::*:role/teched-*"
      }
    ]
  })
}