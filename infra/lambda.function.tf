# Package the Lambda function code
# data "archive_file" "bootstrap" {
#   type        = "zip"
#   source_file = "../build/bootstrap"
#   output_path = "../output/function.zip"
# }

# Lambda function
resource "aws_lambda_function" "sftp_broker" {
  filename      = "../output/function.zip"
  function_name = var.lambda.function_name
  role          = aws_iam_role.sftp_broker_role.arn
  handler       = var.lambda.handler
  code_sha256   = filebase64sha256("../output/function.zip")

  memory_size   = var.lambda.memory_size
  timeout       = var.lambda.timeout
  runtime       = var.lambda.runtime
  architectures = var.lambda.architectures

  ephemeral_storage {
    size = var.lambda.ephemeral_storage.size
  }

  vpc_config {
    subnet_ids         = var.lambda_vpc_configs.private_app_subnet_ids
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy.sftp_broker_s3_policy,
    aws_iam_role_policy.sftp_broker_secrets_policy,
    aws_iam_role_policy_attachment.sftp_broker_AWSLambdaBasicExecutionRole,
    aws_iam_role_policy_attachment.sftp_broker_AWSLambdaVPCAccessExecutionRole
  ]
}