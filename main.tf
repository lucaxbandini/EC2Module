
ami                         = "ami-02c21308fed24a8ab"
instance_type               = "t2.micro"
key_name                    = "LB-EC2-KP"
monitoring                  = true
vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
subnet_id                   = aws_subnet.pri.id
associate_public_ip_address = false

tags = {
  Name = "var.tags"
}