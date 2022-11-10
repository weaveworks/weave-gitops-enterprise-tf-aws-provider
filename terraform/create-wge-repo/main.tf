
resource "github_repository" "repo" {
  name        =  var.values.name
  description = var.values.description
  visibility = var.values.visibility
  template {
    owner      = var.values.template_owner
    repository = var.values.template_repository
  }
}