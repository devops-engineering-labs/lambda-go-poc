resource "aws_lambda_function_url" "sftp_broker" {
  function_name      = aws_lambda_function.sftp_broker.function_name
  authorization_type = "NONE"
}