module "github_module" {
    source = "./github"
    
    github_token = "${var.github_token}"
}

resource "null_resource" "read_output" {
    provisioner "local-exec" {
        command = "echo ${module.github_module.http_clone_url}"
    }
}
