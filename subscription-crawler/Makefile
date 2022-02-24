.PHONY: build-crawler
build-crawler:
	docker build --tag rhsm-crawler $(CURDIR)


.PHONY: crawl
crawl: build-crawler
	docker run -e API_TOKEN --rm -it rhsm-crawler:latest
