variable "aws_region" {
  description = "value"
  type        = string
  sensitive   = false

  default = "us-east-1"
}

variable "assume_role" {
  description = "value"
  type = object({
    role_arn    = string
    external_id = string
  })
  sensitive = true
}

variable "lambda" {
  description = "Configuration object for the AWS Lambda function, including runtime settings, resource allocation, and execution parameters."
  type = object({
    function_name = string
    handler       = string
    memory_size   = number
    timeout       = number
    runtime       = string
    architectures = list(string)
    ephemeral_storage = object({
      size = number
    })
  })
  sensitive = false
}

variable "tags" {
  description = "Map of tags to be applied to AWS resources for identification, organization, and cost allocation."
  type        = map(string)
  sensitive   = false

  default = {
    Environment = "production"
    Application = "sftp-broker"
  }
}