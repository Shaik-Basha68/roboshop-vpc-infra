variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
  
}
variable "Project_Name" {
    type = string
    default = "RoboShop"
}
variable "Environment" {
    type=string
    default = "Dev"
}
variable "tenancy" {
    description = "The tenancy of the VPC"
    type        = string
    default     = "default"
}

variable "tags" {
    description = "The name tag for the VPC"
    type        = map
    default = {
        owner = "DevopsTeam"
        DevopsTeam = "RoboShop"
    }
  
}
variable "public_subnet" {
    description = "List of public subnet CIDR blocks"
    type        = list
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_tags" {
    description = "The name tag for the public subnets"
    type        = map
    default = {
        owner = "DevopsTeam"
        DevopsTeam = "RoboShop"
    }
}

variable "igw_tags" {
    description = "The name tag for the Internet Gateway"
    type        = map
    default = {
        owner = "DevopsTeam"
        DevopsTeam = "RoboShop"
    }
}

variable "private_subnet" {
    description = " private subnet CIDR blocks"
    type        = list
    default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
