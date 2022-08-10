FROM alpine:3.15.4

RUN apk update && apk upgrade && apk add --no-cache redis;

COPY tools/redis_run.sh /tmp/redis_run.sh

CMD ["sh", "/tmp/redis_run.sh"]
