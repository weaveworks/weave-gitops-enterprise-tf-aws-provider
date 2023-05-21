
resource "github_repository" "repo" {
  name        =  var.values.name
  description = var.values.description
  visibility = var.values.visibility
  template {
    owner      = var.values.template_owner
    repository = var.values.template_repository
  }
}

resource "github_team_repository" "cx_team" {
  repository = github_repository.repo.name
  team_id = "cx"
  permission = "maintain"
}

resource "github_team" "some_team" {
  name        = var.values.name
  description = var.values.description
  privacy     = "closed"
}