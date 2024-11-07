resource "aws_eks_cluster" "cluster_lab"{
    name = "eks-${var.prefix}-${var.clusterName}"

    vpc_config {
        subnet_ids  = var.subnet_ids
        security_group_ids = [var.sg_group_id]
   }

    
    role_arn = aws_iam_role.aws_role_eks.arn
    
    enabled_cluster_log_types = ["api","audit"]

    version = var.clusterversion
    
   depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController,
  ]

}


resource "aws_eks_node_group" "node_eks"{

    cluster_name = resource.aws_eks_cluster.cluster_lab.name
    node_group_name = "group-${var.prefix}-${var.clusterName}"
    version = aws_eks_cluster.cluster_lab.version
    node_role_arn = resource.aws_iam_role.node_eks.arn
    subnet_ids      =  var.subnet_ids
    

    scaling_config {
      max_size = var.maxsize
      desired_size = var.desiredsize
      min_size = var.minsize
    }
    instance_types = ["t2.micro"]
    update_config {
      max_unavailable = var.maxunavailable
    }

    depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}