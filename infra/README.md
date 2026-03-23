<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | v1.12.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.sftp_broker_role](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.sftp_broker_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.sftp_broker_secrets_policy](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.sftp_broker_AWSLambdaBasicExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sftp_broker_AWSLambdaVPCAccessExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.sftp_broker](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/lambda_function) | resource |
| [aws_lambda_function_url.sftp_broker](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/lambda_function_url) | resource |
| [aws_security_group.lambda_sg](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.lambda_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_iam_policy_document.sftp_broker_assume_role](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | value | <pre>object({<br/>    role_arn    = string<br/>    external_id = string<br/>  })</pre> | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | value | `string` | `"us-east-1"` | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | Configuration object for the AWS Lambda function, including runtime settings, resource allocation, and execution parameters. | <pre>object({<br/>    function_name = string<br/>    handler       = string<br/>    memory_size   = number<br/>    timeout       = number<br/>    runtime       = string<br/>    architectures = list(string)<br/>    ephemeral_storage = object({<br/>      size = number<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_lambda_vpc_configs"></a> [lambda\_vpc\_configs](#input\_lambda\_vpc\_configs) | VPC configuration for the Lambda function, including the VPC ID and a list of private subnet IDs for application deployment. | <pre>object({<br/>    private_app_subnet_ids = list(string)<br/>    vpc_id                 = string<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to be applied to AWS resources for identification, organization, and cost allocation. | `map(string)` | <pre>{<br/>  "Application": "sftp-broker",<br/>  "Environment": "production"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sftp_broker_function_url"></a> [sftp\_broker\_function\_url](#output\_sftp\_broker\_function\_url) | SFTP Broker Lambda Function URL |
<!-- END_TF_DOCS -->