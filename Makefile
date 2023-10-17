it:
	@echo "make [print|test|build|run]"

print:
	docker buildx bake --print dev

test: print build run

build:
	docker buildx bake dev

run:
	docker run --net=host -it --rm --name=keepalived \
		-e SWARMVIP_SLOT=1 \
		-e SWARMVIP_ADDRESSES=192.168.65.244 \
		--cap-add=NET_RAW \
		--cap-add=NET_ADMIN \
		--cap-add=NET_BROADCAST \
	localhost/keepalived:latest
