terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
        }
        random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
        }
    }


backend "s3" {
    bucket         = "roboshop-terraform-state-bucket-1"
    key            = "roboshop/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    use_lockfile   = true
}   
}

provider "aws" {
    region = "ap-south-1"
}
