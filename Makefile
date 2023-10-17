it:
	@echo "make [print|build|run]"

print:
	docker buildx bake --print

build:
	docker buildx bake

run:
	docker run --net=host -it --rm --name=keepalived localhost/keepalived:latest
