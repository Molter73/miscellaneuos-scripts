.PHONY: build-crawler
build-crawler:
	docker build --build-arg API_TOKEN=$(API_TOKEN) --tag rhsm-crawler $(CURDIR)


.PHONY: crawl
crawl: build-crawler
	docker run --rm -it rhsm-crawler:latest
