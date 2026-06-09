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

# ── Dev user credentials (deliverables) ──────────────────────────────
output "dev_user_access_key_id" {
  description = "Access key ID for bedrock-dev-view"
  value       = aws_iam_access_key.dev_view.id
}

output "dev_user_secret_access_key" {
  description = "Secret access key for bedrock-dev-view"
  value       = aws_iam_access_key.dev_view.secret
  sensitive   = true
}

output "dev_user_console_password" {
  description = "Console password for bedrock-dev-view"
  value       = aws_iam_user_login_profile.dev_view.password
  sensitive   = true
}

output "dev_user_account_id" {
  description = "AWS Account ID for console login URL"
  value       = "https://670088436683.signin.aws.amazon.com/console"
}
