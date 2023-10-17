target "dev" {
    context = "."
    docekrfile = "Dockerfile"
    tags = [
        "localhost/keepalived:latest"
    ]
}
