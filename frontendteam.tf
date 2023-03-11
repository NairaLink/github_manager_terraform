# Someone Elses Contributors GitHub Team
locals {

  frontenders = [
    "Linsmed", "oriafo" #github username
  ]

  fe_repositories = [
    "frontend-app", "frontend-react"
  ]

}

# Create a contributors team
resource "github_team" "frontend" {
  name        = "frontend"
  description = "frontend contributors GitHub Team"
  privacy     = "closed"
}

# Add contributors team as orgnisation member
resource "github_membership" "frontend" {
  for_each = toset(local.frontenders)

  username = each.value
  role     = "member"
}

# Add contributors to github team
resource "github_team_members" "frontenders" {
  for_each = toset(local.frontenders)

  team_id = github_team.frontend.id

  members {
    username = each.value
    role     = "member"
  }

}

# Set permissions to respositories for frontenders github team
resource "github_team_repository" "frontenders" {
  for_each = toset(local.fe_respositories)

  team_id    = github_team.frontend.id
  repository = each.value
  permission = "push"

  depends_on = [
    github_repository.respositories
  ]

}
