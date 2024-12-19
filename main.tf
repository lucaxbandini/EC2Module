resource "aws_instance" "this" {

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = var.monitoring
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = var.tags
  }
}