locals {
  aws_account_id = var.aws_account_id != "" ? var.aws_account_id : data.aws_caller_identity.current.account_id
  # clean URLs of https:// prefix
  urls = [ replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")]
}

resource "aws_iam_policy" "this" {
  name_prefix = var.role_name
  description = var.description
  # policy      = var.policy_document
  policy      = templatefile("${path.module}/test-policy.json.tpl", {})
   
}

resource "aws_iam_role" "this" {
  name                 = var.role_name
  name_prefix          = var.role_name_prefix
  description          = var.description
  path                 = var.role_path
  max_session_duration = var.max_session_duration

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permissions_boundary_arn

  assume_role_policy = join("", data.aws_iam_policy_document.assume_role_with_oidc.*.json)

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = join("", aws_iam_role.this.*.name)
  policy_arn = aws_iam_policy.this.arn
}
