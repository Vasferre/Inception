all: build up ps

build:
		@ clear
		@ cd srcs && docker compose build --no-cache
up:
		@if ! [ -f srcs/.env ]; then \
				echo ".env missing"; \
				exit 1; \
		fi

		@ cd srcs && docker compose up -d
ps:
		@ docker ps
clean: 
		@ -docker rm -f $$(docker ps -aq)
		@ -docker rmi -f $$(docker images -aq)
fclean:
		@ -docker rm -f $$(docker ps -aq)
		@ sleep 1
		@ -docker rmi -f $$(docker images -aq)
		@ sleep 1
		@ -docker volume rm $$(docker volume ls -q)
		@ sleep 1
		@ -docker network rm $$(docker network ls -q)
re: fclean make

.SILENCE:

.PHONY: up clean