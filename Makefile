ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -rf build

.PHONY: build
build: clean
	docker exec brewing_support_go make build && \
	docker exec brewing_support_node /bin/sh -c "cd brew_support/frontend && npm install" && \
	docker exec brewing_support_node /bin/sh -c "cd brew_support/frontend && npm run build" && \
	cp -r $(ROOT_DIR)golang/build $(ROOT_DIR) && \
	cp -r $(ROOT_DIR)node/brew_support/frontend/dist $(ROOT_DIR)build/resources/frontend
