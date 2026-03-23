# IAM role for Lambda execution
data "aws_iam_policy_document" "sftp_broker_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "sftp_broker_role" {
  name               = "sftp-broker-role"
  assume_role_policy = data.aws_iam_policy_document.sftp_broker_assume_role.json
}

resource "aws_iam_role_policy" "sftp_broker_s3_policy" {
  name = "sftp-broker-s3-policy"
  role = aws_iam_role.sftp_broker_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowListBucket"
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::lambda-go-poc"
      },
      {
        Sid    = "AllowReadObjects"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Resource = "arn:aws:s3:::lambda-go-poc/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "sftp_broker_secrets_policy" {
  name = "sftp-broker-secrets-policy"
  role = aws_iam_role.sftp_broker_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowReadSecretsManager"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowReadSSMParameters"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sftp_broker_AWSLambdaBasicExecutionRole" {
  role       = aws_iam_role.sftp_broker_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "sftp_broker_AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.sftp_broker_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}