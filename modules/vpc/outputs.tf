output subnet_ids {

    value = resource.aws_subnet.subnet_lab[*].id

}

output sg_group_id {

    value = aws_security_group.sg_lab.id

}