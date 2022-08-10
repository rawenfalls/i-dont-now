FROM alpine:3.15.4

RUN apk update && apk add --update nodejs npm

ADD ./tools/index.html .
ADD ./tools/start.js .

CMD node start.js
