variable "values" {

  type = object({
    name = optional(string)
    description = optional(string)
    visibility = optional(string)
    template_repository = optional(string)
    template_owner = optional(string)
  })

  default = {
    name = ""
    description = ""
    visibility = ""
    template_repository = ""
    template_owner = ""
  }

}


