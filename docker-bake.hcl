target "docker-metadata-action" {}


target "default" {
    inherits = ["docker-metadata-action"]

    context = "."
    docekrfile = "Dockerfile"
    
}

target "dev" {
    inherits = ["default"]
    tags = [
        "localhost/keepalived:latest"
    ]
}
