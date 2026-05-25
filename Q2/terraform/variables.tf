variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "ap-northeast-1"

}

variable "cluster_name" {

  type = string

  default = "asiyo"

}

variable "eks_version" {

  type = string

  default = "1.31"

}

variable "node_instance_type" {

  type = string

  default = "t3.large"

}

variable "desired_size" {

  default = 2

}

variable "max_size" {

  default = 5

}

variable "min_size" {

  default = 2

}