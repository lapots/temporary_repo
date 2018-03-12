variable "github_token" {}
variable "travisci_token" {}
variable "heroku_api_key" {}

# create repo infrastructure
provider "github" {
    token = "${var.github_token}"
    organization = ""
}

resource "github_repository" "sandbox" {
    name = "sandbox-application"
    description = "sandbox application for testing functionality"
    
    auto_init = true
    /*
    provisioner "local-exec" {
        # fix issue with that
        command = "git init && git remote add origin ${github_repository.sandbox.http_clone_url}"
    }
    */
     # copy .travis.yml
     provisioner "file" {
        source = "M:/projects in development/.travis.yml"
        destination = "M:/projects in development/sandbox-application"
     }
     
     # copy .gitignore 
     provisioner "file" {
        source = "M:/projects in development/.gitignore"
        destination = "M:/projects in development/sandbox-application"
     }
}

# create CI chain
provider "travisci" {
    github_owner = "lapots"
    travisci_token = "${var.travisci_token}"
}

resource "travisci_repository" "sandbox" {
    slug = "${github_repository.sandbox.full_name}"
}

# create cloud infrastructure
provider "heroku" {
    email = "sebastrident@gmail.com"
    api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "sandbox" {
    name = "sandbox-ui"
    region = "us"
    
    buildpacks = [
        "heroku/gradle"
    ]
}

# instantiate project
resource "null_resource" "project" {
    /*
    provisioner "local-exec" {
        # fix issue with 
        command = "spring init --build gradle --b 2.0.0 -a sandbox-application -g com.lapots.breed.sandbox -j 1.8 -x -d reactive-web,jpa"
    }
    */
}
