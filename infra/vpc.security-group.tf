resource "aws_security_group" "lambda_sg" {
  name        = "lambda-vpc-access-sg"
  description = "SG for Lambda: Allows access to RDS and external APIs via HTTPS"
  vpc_id      = var.lambda_vpc_configs.vpc_id

  tags = merge({ Name = "lambda-vpc-access-sg" }, var.tags)
}

resource "aws_vpc_security_group_egress_rule" "lambda_all_outbound" {
  security_group_id = aws_security_group.lambda_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}