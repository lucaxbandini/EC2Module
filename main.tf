resource "aws_instance" "this" {

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.kms_name
  monitoring                  = var.monitoring
  vpc_security_group_ids      = [aws_security_group.this.name]
  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = var.tags
  }

}
resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "security group for ec2 terraform"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ingress_cidr_blocks]
    ipv6_cidr_blocks = [var.ingress_ipv6_cidr_blocks]
  }

  egress {
    description      = "Allow https outbound traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.egress_cidr_blocks]
    ipv6_cidr_blocks = [var.egress_ipv6_cidr_blocks]
  }

  tags = {
    Name = var.sg_tag_name
  }

}
resource "aws_kms_key" "this" {
  description             = "An example symmetric encryption KMS key"
  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = var.deletion_window_in_days
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Admin"
        },
        Action = [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Developer"
        },
        Action = [
          "kms:Sign",
          "kms:Verify",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
  })
}