terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "NairaLink"

    workspaces {
      name = "automation-iac-devops"
    }
  }
}
