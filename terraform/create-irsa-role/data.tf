data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_eks_cluster" "cluster" {
   name = var.cluster_name
}

data "aws_iam_policy_document" "assume_role_with_oidc" {
  dynamic "statement" {
    for_each = local.urls

    content {
      effect = "Allow"

      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type = "Federated"

        identifiers = ["arn:${data.aws_partition.current.partition}:iam::${local.aws_account_id}:oidc-provider/${statement.value}"]
      }

      dynamic "condition" {
        for_each = length(var.oidc_fully_qualified_subjects) > 0 ? local.urls : []

        content {
          test     = "StringEquals"
          variable = "${statement.value}:sub"
          values   = var.oidc_fully_qualified_subjects
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_subjects_with_wildcards) > 0 ? local.urls : []

        content {
          test     = "StringLike"
          variable = "${statement.value}:sub"
          values   = var.oidc_subjects_with_wildcards
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_fully_qualified_audiences) > 0 ? local.urls : []

        content {
          test     = "StringLike"
          variable = "${statement.value}:aud"
          values   = var.oidc_fully_qualified_audiences
        }
      }
    }
  }
}
