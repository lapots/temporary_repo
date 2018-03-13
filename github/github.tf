# create repo infrastructure
provider "github" {
    token = "${var.github_token}"
    organization = ""
}

resource "github_repository" "sandbox" {
    name = "sandbox-application"
    description = "sandbox application for testing functionality"
    
    auto_init = true
}
