locals {

  respositories = [
    "automation-cicd-devops",
    "frontend",
    "backend",
    "documentation",
    "system-architecture"
  ]

}


# Create new repository from template
resource "github_repository" "respositories" {
  count = length(local.respositories)

  name               = local.respositories[count.index]
  description        = "Repository generated by Terraform"
  gitignore_template = "Terraform"
  visibility         = "public"
  auto_init          = true

  template {
    owner      = var.github_org
    repository = "repo-template"
  }
}

# Branch Protection Rules
resource "github_branch_protection" "branch_protection" {
  count = length(github_repository.respositories)

  repository_id  = github_repository.respositories[count.index].id
  pattern        = "main"
  # enforce_admins = true

  required_pull_request_reviews {
    require_code_owner_reviews      = true
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
  }

}

resource "github_branch" "branch_development" {
  count = length(github_repository.respositories)

  repository = github_repository.respositories[count.index].name
  branch     = "development"
  source_branch = "main"
}

# resource "github_branch" "branch_test" {
#   count = length(github_repository.respositories)

#   repository = github_repository.respositories[count.index].name
#   branch     = "test"
#   source_branch = "main"
# }

# resource "github_branch" "branch_production" {
#   count = length(github_repository.respositories)

#   repository = github_repository.respositories[count.index].name
#   branch     = "production"
#   source_branch = "main"
# }

resource "github_branch_default" "default" {
  count = length(github_repository.respositories)

  repository = github_repository.respositories[count.index].name
  branch     = "main"
}
