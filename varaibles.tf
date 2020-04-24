variable "aws_region" {
  default = "ap-south-1"
}

variable "cluster-name" {
  default = "zcluster"
  type    = string
}

variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
  type    = string
}

variable "subnet_cidr_block" {
  default = "10.10.1.0/24"
  type    = string
}

variable "availability_zone" {
  default = "ap-south-1a"
  type    = string
}

variable "env_prefix" {
  default = "dev"
  type    = string
}


