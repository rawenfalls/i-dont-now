FROM alpine:3.15.4

RUN apk update && apk upgrade && apk add --no-cache npm && npm install -g redis-commander;

CMD ["sh", "-c", "redis-commander --redis-host=${REDIS_HOST}"]
