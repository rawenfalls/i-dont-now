FROM alpine:3.15.4

RUN apk update && apk upgrade && apk add --no-cache \
	mariadb mariadb-common mariadb-client \
	rm -rf /var/cache/apk/*

COPY ./tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

CMD ["sh", "/tmp/run.sh"]
