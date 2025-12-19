module "vpc" {
  source = "../module"
  cidr_block =  var.vpc_cidr
    Project_Name = var.Project_Name
    Environment = var.Environment
    tenancy = var.tenancy
    tags = var.tags
    public_subnet = var.public_subnet
    public_subnet_tags = var.public_subnet_tags 
    igw_tags = var.igw_tags
    public_rt_tags = var.public_subnet_tags
    private_subnet = var.private_subnet
    private_subnet_tags = var.public_subnet_tags
}
