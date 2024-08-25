variable "env" {
  type    = string
  default = "dev"

}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets1" {
  description = "A list of public subnets"
  type        = string
}

variable "public_subnets2" {
  description = "A list of public subnets"
  type        = string
}

variable "private_subnets1" {
  description = "A list of public subnets"
  type        = string
}

variable "private_subnets2" {
  description = "A list of public subnets"
  type        = string
}
