variable "ami" {
  type        = string
  description = "The AMI resource allows the creation and management of a completely-custom Amazon Machine Image (AMI). e.g. ami-02c21308fed24a8ab"
  default     = ""
}


variable "monitoring" {
  type    = bool
  default = true
}