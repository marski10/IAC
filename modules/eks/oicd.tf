data "aws_eks_cluster" "main" {
  name = resource.aws_eks_cluster.cluster_lab.name
}

data "tls_certificate" "main" {
  url = resource.aws_eks_cluster.cluster_lab.identity[0].oidc[0].issuer
}


output "url" {
  value = resource.aws_eks_cluster.cluster_lab.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list  = ["sts.amazonaws.com","eks.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.main.certificates[0].sha1_fingerprint]
  url             = resource.aws_eks_cluster.cluster_lab.identity[0].oidc[0].issuer
}
