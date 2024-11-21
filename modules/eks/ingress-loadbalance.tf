


resource "aws_eks_pod_identity_association" "main" {
  cluster_name    =  resource.aws_eks_cluster.cluster_lab.name
  namespace       = "kube-system"
  service_account = resource.kubernetes_service_account.main.metadata[0].name
  role_arn        = resource.aws_iam_role.eks_elb.arn

  depends_on = [kubernetes_service_account.main]
}