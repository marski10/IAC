module "aws-dev"{
    source = "../../infra"
    machine = "t2.micro"
    regiao_aws = "us-east-1"
    chave = "IAC-dev"
    security_name = "dev"
    name_group = "grupo-dev"
    minsize = 0
    maxsize = 1
}
