resource "aws_cloudwatch_log_group" "eks_cloudwatch"{
    name = "eks/${var.prefix}-${var.clusterName}/cluster"
    retention_in_days = var.rententiondays
}