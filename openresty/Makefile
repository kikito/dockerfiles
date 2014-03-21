TEMPLATE=kikito/openresty
TAG=0.6

all: build

build:
	docker build -t $(TEMPLATE):$(TAG) -rm .
run:
	docker run -d -p 80:80 -v ~/nginx/www:/usr/share/nginx/www -v ~/nginx/log:/var/log/nginx -v ~/nginx/conf:/etc/nginx/conf.d -t $(TEMPLATE):$(TAG)
bash:
	docker run -i -p 80:80 -v ~/nginx/www:/usr/share/nginx/www -v ~/nginx/log:/var/log/nginx -v ~/nginx/conf:/etc/nginx/conf.d -t $(TEMPLATE):$(TAG) /bin/bash
push:
	docker push $(TEMPLATE)
