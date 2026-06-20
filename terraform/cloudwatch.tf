# ── CloudWatch Observability Add-on ───────────────────────────────────
data "aws_iam_roles" "node_roles" {
  name_regex  = "managed-nodegroup-.*-eks-node-group-.*"
  path_prefix = "/"

  depends_on = [module.retail_app_eks]
}

resource "aws_iam_role_policy_attachment" "cloudwatch_nodes" {
  for_each   = data.aws_iam_roles.node_roles.names
  role       = each.value
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Install CloudWatch Observability add-on
resource "aws_eks_addon" "cloudwatch_observability" {
  cluster_name                = "project-bedrock-cluster"
  addon_name                  = "amazon-cloudwatch-observability"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [module.retail_app_eks]

  tags = {
    Project = "karatu-2025-capstone"
  }
}