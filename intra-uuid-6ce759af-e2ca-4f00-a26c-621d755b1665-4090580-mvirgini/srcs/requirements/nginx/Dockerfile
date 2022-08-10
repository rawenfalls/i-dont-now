FROM alpine:3.15.4

RUN    apk update && apk upgrade && apk add --no-cache \
        nginx \
        openssl

# nginx SSL
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/mvirgini.pem \
        -keyout /etc/nginx/ssl/mvirgini.key \
        -subj "/C=RU/ST=StPetersburg/L=StPetersburg/O=42 School/OU=21schoolMSK/CN=mvirgini/"

# nginx config
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/http.d/www.mvirgini.ru.conf

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
