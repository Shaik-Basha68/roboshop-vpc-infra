resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    tags = merge(
        var.tags,
        local.common_tags,
        {
            Name = "vpc-${local.common_name_suffix}"
        }
    )
    enable_dns_hostnames = true 
    instance_tenancy = var.tenancy
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.igw_tags,
        local.common_tags,
        {
            Name = "igw-${local.common_name_suffix}"
        }
    )
}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.main.id
    count=length(var.public_subnet)
    cidr_block = var.public_subnet[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true
    tags = merge(
        var.public_subnet_tags,
        local.common_tags,
        { 
            Name = "${local.common_name_suffix}-public-subnet-${count.index + 1}"
        }
    )
    }

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.public_rt_tags,
        local.common_tags,
        {
            Name = "public-rt-${local.common_name_suffix}"
        }
    )
}

resource "aws_route" "public_rt_route" {
    route_table_id         = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "prta" {
    count          = length(aws_subnet.public)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.main.id
    count=length(var.private_subnet)
    cidr_block = var.private_subnet[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = false
    tags = merge(
        var.private_subnet_tags,
        local.common_tags,
        { 
            Name = "${local.common_name_suffix}-private-subnet-${count.index + 1}"
        }
    )
}

resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnet)
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.private_rt_tags,
    local.common_tags,
    {
      Name = "private-rt-${local.common_name_suffix}-${count.index + 1}"
    }
  )
}

resource "aws_route_table_association" "prta_private" {
    count          = length(aws_subnet.private)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private_rt[count.index].id
  
}

resource "aws_eip" "elastic_ip" {
     count = length(aws_subnet.public)
    tags = merge(
        var.elastic_ip_tags,
        local.common_tags,
        {
            Name = "eip-${local.common_name_suffix}-${count.index+1}"
        }
    )
  
}

resource "aws_nat_gateway" "nat_gw" {
    count=length(aws_subnet.public)
    allocation_id = aws_eip.elastic_ip[count.index].id
    subnet_id     = aws_subnet.public[count.index].id
    tags = merge(
        var.nat_gateway_tags,
        local.common_tags,
        {
            Name = "nat-gw-${local.common_name_suffix}-${count.index+1}"
        }
    )
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "private_rt_route" {
    count=length(aws_subnet.private)
    route_table_id         = aws_route_table.private_rt[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_gw[count.index].id
}
