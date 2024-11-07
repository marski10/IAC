resource "aws_vpc" "vpc_lab" {
    enable_dns_hostnames = true
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${var.prefix}-vpc"
    }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet_lab"{
    count = var.quantidade
    vpc_id = aws_vpc.vpc_lab.id
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true
    cidr_block = "10.0.${count.index}.0/24" 
    tags = {
        Name = "subnet-${var.prefix}-${count.index}"
    }
}

resource "aws_internet_gateway" "igw_lab" {
    vpc_id = aws_vpc.vpc_lab.id
    tags =  {
        Name = "igw_${var.prefix}"
    }
}

resource "aws_route_table" "route_table_lab"{
    vpc_id = resource.aws_vpc.vpc_lab.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = resource.aws_internet_gateway.igw_lab.id
    }

    tags = {
        Name = "rtb_${var.prefix}"
    }

}


resource "aws_route_table_association"  "association_table_lab" {
    count = var.quantidade
    route_table_id = resource.aws_route_table.route_table_lab.id
    subnet_id = aws_subnet.subnet_lab.*.id[count.index]
}


resource "aws_security_group" "sg_lab" {

    egress  {
        from_port = 0
        to_port = 0 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
        prefix_list_ids = [] 
    }

    ingress  {
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    
    vpc_id = aws_vpc.vpc_lab.id
    
    tags = {
        Name = "sg_${var.prefix}"
    }


}

