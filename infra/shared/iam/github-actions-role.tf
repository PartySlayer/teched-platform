# Definisce GitHub come provider OIDC, bisogna importare prima
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

