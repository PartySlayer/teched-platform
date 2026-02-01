# Definisce GitHub come provider OIDC
resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]

  # Serve per la CA di GitHub.
  # È pubblico e standard per GitHub Actions, copiato così come è.
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# Data source per generare la Trust Policy in modo pulito
data "aws_iam_policy_document" "github_trust_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # Limita l'accesso solo ai miei repository
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:PartySlayer/teched-platform:ref:refs/heads/main"]
    }
  }
}

# Creazione del Ruolo IAM
resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsDeployRole"
  assume_role_policy = data.aws_iam_policy_document.github_trust_policy.json
}

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

      # 
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
        Sid    = "PassRole"
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = "arn:aws:iam::*:role/teched-*"
      }
    ]
  })
}