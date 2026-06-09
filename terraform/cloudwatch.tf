# ── CloudWatch Observability Add-on ───────────────────────────────────
# Gives nodes permission to send logs to CloudWatch
resource "aws_iam_role_policy_attachment" "cloudwatch_node_group_1" {
  role       = "managed-nodegroup-1-eks-node-group-20260608201522749100000013"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_node_group_2" {
  role       = "managed-nodegroup-2-eks-node-group-20260608201522927500000014"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_node_group_3" {
  role       = "managed-nodegroup-3-eks-node-group-20260608201523232300000015"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Install CloudWatch Observability add-on
resource "aws_eks_addon" "cloudwatch_observability" {
  cluster_name                = "project-bedrock-cluster"
  addon_name                  = "amazon-cloudwatch-observability"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    Project = "karatu-2025-capstone"
  }
}
