data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_eks_cluster" "cluster" {
   name = var.values.cluster_name
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
        for_each = var.values.oidc_fully_qualified_subjects == null ? local.urls : []

        content {
          test     = "StringEquals"
          variable = "${statement.value}:sub"
          values   = var.values.oidc_fully_qualified_subjects
        }
      }

      dynamic "condition" {
        content {
          test     = "StringLike"
          variable = "${statement.value}:sub"
          values   = var.values.oidc_subjects_with_wildcards
        }
      }
    }
  }
}
