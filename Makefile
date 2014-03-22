all: clean

clean: rm_sleeping_dockers rm_orphan_images

rm_sleeping_dockers:
	docker rm $$(docker ps -a -q) ; true

rm_orphan_images:
	docker rmi $$(docker images | awk '/^<none>/ { print $$3 }') ; true

killall:
	docker ps -a -q | xargs docker stop | xargs docker rm

