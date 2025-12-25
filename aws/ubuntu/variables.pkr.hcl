variable "business_divsion" {
  description = "Business Division"
  type        = string
  default     = "devops"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "prod"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}