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
          aws_s3_bucket.terraform_state.arn,
          "${aws_s3_bucket.terraform_state.arn}/*",
          aws_dynamodb_table.terraform_locks.arn
        ]
      },

      # Permessi di sola lettura per terraform plan
      {
        Sid    = "ReadOnlyGlobal"
        Effect = "Allow"
        Action = [
          "ecs:Describe*",
          "ecs:List*",
          "rds:Describe*",
          "iam:Get*",
          "iam:List*",
          "secretsmanager:Describe*",
          "secretsmanager:ListSecrets",

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
          "alb:*",
          "api-gateway:*",
          "s3:*",
          "cloudfront:*",
          "acm:*"



        ]
        Resource = [

          "arn:aws:ecs:*:*:/teched-*",

          "arn:aws:rds:*:*:db:teched-*",
          "arn:aws:rds:*:*:snapshot:teched-*",

          # Secrets Manager
          "arn:aws:secretsmanager:*:*:secret:teched-*"
        ]
      },

      # IAM sia scritto in modo puntuale che perché "*" è pericoloso
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