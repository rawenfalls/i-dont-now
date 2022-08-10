
NAME = inception

all: prune start

host:
	@ echo "127.0.0.1 mvirgini.42.fr" >> /etc/hosts

unhost:
	@ sed -i '/127.0.0.1 mvirgini.42.fr/d' /etc/hosts

stop:
	@ docker-compose -f srcs/docker-compose.yml down

clean: stop unhost
	@ rm -rf /home/mvirgini/data

prune: clean
	@ docker system prune -f -a

start: host
	@ docker-compose -f srcs/docker-compose.yml up -d --build

.PHONY: host start stop clean prune all
