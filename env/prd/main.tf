module "aws-prod"{
    source = "../../infra"
    machine = "t2.micro"
    regiao_aws = "us-east-1"
    chave = "IaC-Prod"
    security_name = "prod"
    minsize = 3
    maxsize = 5
    name_group  = "grupo-prod"

}

