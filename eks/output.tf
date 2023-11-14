output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_role_arn" {
    description = "This is the cluster role arn"
    value = aws_eks_cluster.eks.role_arn
}