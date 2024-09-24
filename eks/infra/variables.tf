

variable "region" {
    type = string
    description = "Region"
    default = "east-1"
}


variable "available_zones" {
    type = list(string)
    description = "Avalaible Zones"
    default = ["us-east-1a","us-east-1b"]
}

variable "cidrip4" {
    type = string
    description = "CIDR IPV4 FOR VPC"
    default = "172.0.0.0/16"
}

variable "cidrip6" {
    type = string
    description = "CIDR IPV6 FOR VPC"
    default = "2001:db8:1234:1a00::/56"
}

variable "cird_private_subnet_ipv4" {
    type = list(string)
    description = "Subnet CIRD IPV4 private and public"
    default = ["172.0.2.0/24","172.0.1.0/24"]
}

variable "cird_private_subnet_ipv6" {
    type = list(string)
    description = "Subnet CIRD IPV6 private and public"
    default = ["2001:db8:1234:1a00::/64","2001:db8:1234:1a00::/64"]
}

