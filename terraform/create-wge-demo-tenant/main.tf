
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

resource "github_team" "team" {
  name        = var.values.name
  description = var.values.description
  privacy     = "closed"
}
resource "github_team_members" "some_team_members" {
  team_id  = github_team.team.id

  members {
    username = var.values.github_user
    role     = "member"
  }
}

resource "github_team_repository" "tenant_team" {
  repository = github_repository.repo.name
  team_id = github_team.team.id
  permission = "push"
}
