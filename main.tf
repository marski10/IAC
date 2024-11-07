module vpc_lab {

    source = "./modules/vpc"
    prefix = var.prefix
    quantidade = var.quantidade

}


module cluster_lab {

    source = "./modules/eks"
    prefix = var.prefix
    clusterName = var.clusterName
    subnet_ids = module.vpc_lab.subnet_ids
    sg_group_id = module.vpc_lab.sg_group_id
    clusterversion = var.clusterversion
    maxsize = var.maxsize
    desiredsize = var.desiredsize
    minsize = var.minsize
    maxunavailable = var.maxunavailable
    rententiondays = var.rententiondays
}

# module lab_buckets {
#     source = "./modules/bucket"
# }

# module lab_rds {
#     source = "./modules/rds"
#     vpc_sg = module.vpc_lab.sg_group_id
#     subnet_ids = module.vpc_lab.subnet_ids
# }