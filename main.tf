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