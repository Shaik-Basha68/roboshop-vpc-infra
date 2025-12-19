variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "tags" {
    description = "The name tag for the VPC"
    type        = map
    default = {}
}

variable "Project_Name" {
    type = string
  
}

variable "Environment" {
    type=string
  
}

variable "tenancy" {
    description = "The tenancy of the VPC"
    type        = string
}
variable "igw_tags" {
    description = "The name tag for the Internet Gateway"
    type        = map
    default = {}
}
variable "public_subnet" {
    description = "List of public subnet CIDR blocks"
    type        = list
}
variable "public_subnet_tags" {
    description = "The name tag for the public subnets"
    type        = map
    default = {}
}
variable "public_rt_tags" {
    description = "The name tag for the public route table"
    type        = map
    default = {}
  
}
variable "private_subnet" {
    description = " private subnet CIDR blocks"
    type        = list
}

variable "private_subnet_tags" {
    description = "The name tag for the private subnets"
    type        = map
    default = {}
}

variable "private_rt_tags" {
    description = "The name tag for the private route table"
    type        = map
    default = {}
}

variable "elastic_ip_tags" {
    description = "The name tag for the EIP"
    type        = map
    default = {}
  
}
variable "nat_gateway_tags" {
    description = "The name tag for the NAT Gateway"
    type        = map
    default = {}
}