resource "aws_vpc" "eks_vpc" {

    cidr_block = vars.cidrip4
    ipv6_cidr_block = vars.cidrip6
    instance_tenancy = "default"

    tags = {
        Name = "eks_vpc"
    }
}

resource "aws_subnet" "private_eks_subnet" {

    vpc_id = aws_vpc.eks_vpc.id
    ipv6_cidr_block = vars.cird_private_subnet_ipv6[0]
    cidr_block = vars.cird_private_subnet_ipv4[0]
    availability_zone = vars.availability_zones

}

resource "aws_subnet" "public_eks_subnet" {

    vpc_id = aws_vpc.eks_vpc.id
    ipv6_cidr_block = vars.cird_private_subnet_ipv6[1]
    cidr_block = vars.cird_private_subnet_ipv4[1]
    availability_zone = vars.availability_zones

}

resource "aws_internet_gateway" "eks_internet_gateway" {

    vpc_id = aws_vpc.eks_vpc.id
    tags = {
        Name = "eks_internet_gateway"   
    }

}

resource "aws_nat_gateway" "eks_nat_gateway" {

    subnet_id = aws_subnet.private_eks_subnet.id
    tags = { 
        name = "eks_nat_gateway"
    }
}


resource "aws_route_table" "eks_route_table" {

    vpc_id = aws_vpc.eks_vpc.id


    route{
        cidr_block  = vars.cidrip4    
        egress_only_gateway_id = aws_nat_gateway.eks_nat_gateway    
    }

    route{
        ipv6_cidr_block = vars.cidrip6
        egress_only_gateway_id = aws_nat_gateway.eks_nat_gateway 

    }

    tags = {

        Name = "eks_route_table"

    }

}