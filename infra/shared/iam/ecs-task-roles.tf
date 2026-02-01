# Trust Policy
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Ruolo per AuthService
resource "aws_iam_role" "auth_task_role" {
  name               = "auth-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

data "aws_iam_policy_document" "auth_task_policy" {
  # Secret sola lettura (JWT, credenziali DB)
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["*"]
  }

  # CloudWatch Logs
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/ecs/teched-*"]
  }
}

resource "aws_iam_role_policy" "auth_task_policy" {
  role   = aws_iam_role.auth_task_role.id
  policy = data.aws_iam_policy_document.auth_task_policy.json
}

# Ruolo per LearnService

resource "aws_iam_role" "learn_task_role" {
  name               = "learn-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

data "aws_iam_policy_document" "learn_task_policy" {

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["*"]
  }

  # Get oggetti da S3 per i video (per generare i presigned url)
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = ["arn:aws:s3:::teched-*/*"]
  }

  # CloudWatch Logs
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/ecs/teched-*"]
  }
}

resource "aws_iam_role_policy" "learn_task_policy" {
  role   = aws_iam_role.learn_task_role.id
  policy = data.aws_iam_policy_document.learn_task_policy.json
}

# RUolo per PaymentsERVICE
resource "aws_iam_role" "payments_task_role" {
  name               = "payments-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

data "aws_iam_policy_document" "payments_task_policy" {

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["*"]
  }

  # CloudWatch Logs
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/ecs/payments*"]
  }
}

resource "aws_iam_role_policy" "payments_task_policy" {
  role   = aws_iam_role.payments_task_role.id
  policy = data.aws_iam_policy_document.payments_task_policy.json
}