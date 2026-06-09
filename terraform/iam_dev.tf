# ── IAM User ──────────────────────────────────────────────────────────
resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"
  tags = {
    Project = "karatu-2025-capstone"
  }
}

# ── Console password ──────────────────────────────────────────────────
resource "aws_iam_user_login_profile" "dev_view" {
  user                    = aws_iam_user.dev_view.name
  password_reset_required = false
}

# ── Access key (for CLI + grader) ─────────────────────────────────────
resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}

# ── ReadOnlyAccess (console read) ─────────────────────────────────────
resource "aws_iam_user_policy_attachment" "dev_view_readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# ── S3 PutObject on assets bucket (for grader Lambda test) ────────────
resource "aws_iam_user_policy" "dev_view_s3" {
  name = "bedrock-dev-view-s3-put"
  user = aws_iam_user.dev_view.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::bedrock-assets-alt-soe-025-4763/*"
      }
    ]
  })
}

# ── Patch aws-auth ConfigMap to add the IAM user ──────────────────────
resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  force = true

  data = {
    mapUsers = yamlencode([
      {
        userarn  = aws_iam_user.dev_view.arn
        username = "bedrock-dev-view"
        groups   = []
      }
    ])
  }
}

# ── Kubernetes RBAC: bind view ClusterRole to this user ───────────────
resource "kubernetes_cluster_role_binding_v1" "dev_view" {
  metadata {
    name = "bedrock-dev-view-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind      = "User"
    name      = "bedrock-dev-view"
    api_group = "rbac.authorization.k8s.io"
  }
}
