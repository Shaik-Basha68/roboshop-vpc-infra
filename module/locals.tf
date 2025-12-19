locals {
    common_tags={
        Project_Name=var.Project_Name
        Environment=var.Environment
        terraform=true
    }
    common_name_suffix="${var.Project_Name}-${var.Environment}"
az=slice(data.aws_availability_zones.available.names, 0, 2)
}