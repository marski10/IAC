


resource "aws_eks_pod_identity_association" "main" {
  cluster_name    =  resource.aws_eks_cluster.cluster_lab.name
  namespace       = "kube-system"
  service_account = "alb-ingress-controller" #resource.kubernetes_service_account.main.metadata[0].name
  role_arn        = aws_iam_role.eks_elb.arn

  depends_on = [kubernetes_service_account.main]
  
}

