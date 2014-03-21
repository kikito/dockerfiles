TEMPLATE=kikito/base
TAG=0.5

all: build

build:
	docker build -t $(TEMPLATE):$(TAG) -rm .
daemon:
	docker run -d -p 80:80 -v ~/nginx/www:/usr/share/nginx/www -v ~/nginx/log:/var/log/nginx -t $(TEMPLATE):$(TAG)
bash:
	docker run -i -p 80:80 -v ~/nginx/www:/usr/share/nginx/www -v ~/nginx/log:/var/log/nginx -t $(TEMPLATE):$(TAG) /bin/bash
push:
	docker push $(TEMPLATE)
killall:
	docker ps -a -q | xargs docker stop | xargs docker rm
