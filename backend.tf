terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "NairaLink"

    workspaces {
      name = "github_manager_terraform"
    }
  }
}
