variable "regiao_aws" {
    type = string
    description = "Regiao aws"
    default = "us-east-1"
}


variable "chave" { 
    type = string
    description = "Chave de acesso"

}


variable "machine" {
    type = string
    description = "Tipo de maquina"
    default = "t2.micro"  
}

variable "security_name" {
    type = string
    description = "Nome do security group"
    default = "devops"
}


variable name_group {

    type = string
    default = "grupo"

}

variable "minsize" {
    type = number
    description = "Minimo de instancias"
    default = 1
}


variable "maxsize" {

    type = number
    description = "Maximo de instancias"
    default= 2


}