data "aws_region" "current" {}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.cluster_lab.endpoint}
    certificate-authority-data: ${aws_eks_cluster.cluster_lab.certificate_authority[0].data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: "${aws_eks_cluster.cluster_lab.name}"
  name: "${aws_eks_cluster.cluster_lab.name}"
current-context: "${aws_eks_cluster.cluster_lab.name}"
kind: Config
preferences: {}
users:
- name: "${aws_eks_cluster.cluster_lab.name}"
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - "${data.aws_region.current.name}"
      - eks
      - get-token
      - --cluster-name
      - "${aws_eks_cluster.cluster_lab.name}"
      - --output
      - json
      command: aws
KUBECONFIG
}

resource "local_file" "kubeconfig" {
  filename = "kubeconfig"
  content = local.kubeconfig
}
