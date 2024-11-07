variable "prefix" {
    type = string
    default = "Generic"
    description = "prefix to resources created in aws"
}

variable "clusterName" {
    type = string
    default = "Generic"
    description = "cluster name in eks aws"
}

variable "rententiondays" {
    type = number
    default = 1 
    description = "Retentions day in cloudwatch aws"  
}

variable "desiredsize" {
    type = number
    default = 1 
}

variable "minsize" {
    type = number
    default = 1 
}

variable "maxsize" {
    type = number
    default = 2
}

variable "maxunavailable" {
    type = number
    default = 1 
}

variable "clusterversion" {
   type = number
   default = 1 
}

// variables via output

variable "subnet_ids" {
    description = "subnet id"
}

variable sg_group_id {
  description = "security group id"

}