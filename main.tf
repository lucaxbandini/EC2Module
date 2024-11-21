locals {
  tags = {
    terraform   = "true"
    project     = "luca-ec2-module"
    Environment = "dev"
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "luca-ec2-module"

  ami                         = "ami-02c21308fed24a8ab"
  instance_type               = "t2.micro"
  key_name                    = "LB-EC2-KP"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = aws_subnet.pri.id
  associate_public_ip_address = false

  user_data = <<EOF
  #!/bin/bash
  yum update -y
  yum install httpd -y
  yum install httpd-tools -y
  systemctl start httpd
  systemctl enable httpd
  echo "<html><h1> This is the EC2 module! </h1><html>" >> /var/www/html/index.html
  EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "LucaEC2vpc"
  }
}

resource "aws_subnet" "pri" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "LucaEC2sn"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "luca-ec2-sg"
  description = "Security group for Luca EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}