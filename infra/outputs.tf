output "sftp_broker_function_url" {
  description = "SFTP Broker Lambda Function URL"
  value       = aws_lambda_function_url.sftp_broker.function_url
  sensitive   = false
}