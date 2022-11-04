variable "values" {

  type = object({
    policy_document = optional(string)
    cluster_name = optional(string)
    # aws_account_id = optional(string)
    tags = optional(map(string))
    role_name = optional(string)
    role_name_prefix = optional(string)
    description = optional(string)
    role_path = optional(string)
    role_permissions_boundary_arn = optional(string)
    max_session_duration = optional(number)
    role_policy_arns = optional(list(string))
    number_of_role_policy_arns = optional(number)
    oidc_fully_qualified_subjects = optional(list(string))
    oidc_subjects_with_wildcards = optional(list(string))
    oidc_fully_qualified_audiences = optional(list(string))
    force_detach_policies = optional(bool)
  })

  default = {
    policy_document = ""
    cluster_name = ""
    # aws_account_id = ""
    tags = {}
    role_name = ""
    role_name_prefix = ""
    description = ""
    role_path = "/"
    role_permissions_boundary_arn =""
    max_session_duration = 3600
    role_policy_arns = []
    number_of_role_policy_arns = null
    oidc_fully_qualified_subjects = []
    oidc_subjects_with_wildcards = []
    oidc_fully_qualified_audiences = []
    force_detach_policies = false
  }

}


