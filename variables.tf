variable "ami" {
  type        = string
  description = "The AMI resource allows the creation and management of a completely-custom Amazon Machine Image (AMI). e.g. ami-02c21308fed24a8ab"
  default     = ""
}

variable "instance_type" {
  type    = string
  default = ""
}

variable "kms_name" {
  type    = string
  default = ""
}

variable "monitoring" {
  type    = bool
  default = true
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "tags" {
  type    = string
  default = ""
}

variable "sg_name" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "ingress_cidr_blocks" {
  type    = string
  default = ""
}

variable "ingress_ipv6_cidr_blocks" {
  type    = string
  default = ""
}

variable "egress_cidr_blocks" {
  type    = string
  default = ""
}

variable "egress_ipv6_cidr_blocks" {
  type    = string
  default = ""
}

variable "sg_tag_name" {
  type    = string
  default = ""
}

variable "enable_key_rotation" {
  type    = bool
  default = true
}

variable "deletion_window_in_days" {
  type    = string
  default = "20"
}

variable "aws_caller_identity" {
  type = string
  default = ""
}