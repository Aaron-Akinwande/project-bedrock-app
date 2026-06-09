output "configure_kubectl" {
  description = "Command to update kubeconfig for this cluster"
  value       = module.retail_app_eks.configure_kubectl
}

output "retail_app_url" {
  description = "URL to access the retail store application"
  value = try(
    "http://${data.kubernetes_service.ui_service.status[0].load_balancer[0].ingress[0].hostname}",
    "LoadBalancer provisioning - run: kubectl get svc -n ui ui"
  )
}

# ── Required grading outputs ──
output "cluster_name" {
  description = "EKS cluster name"
  value = "project-bedrock-cluster"
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.retail_app_eks.cluster_endpoint
}

output "region" {
  description = "AWS region"
  value       = "us-east-1"
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.inner.vpc_id
}

output "assets_bucket_name" {
  description = "S3 assets bucket name"
  value       = "bedrock-assets-alt-soe-025-4763"
}
