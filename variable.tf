#########################################
#Variable File for Complete Main Module.#
#########################################
variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "region" {
  default = "ap-southeast-2"
}

####################
#Variables for VPC.#
####################

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "azs" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "keyname" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = "aws368"
}