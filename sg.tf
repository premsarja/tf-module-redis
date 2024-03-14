
resource "aws_security_group" "allows_redis" {
  name        = "redis allows internal traffic"
  description = "Allow private traffics"
  vpc_id =   data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "redis  from private network "
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_CIDR[0]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-redis-sg   "
  }
}

