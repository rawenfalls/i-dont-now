FROM alpine:3.15.4

RUN apk update && apk upgrade && apk add --no-cache \
	wget \
    php7-common php7-iconv php7-json \
    php7-gd php7-curl php7-xml \
    php7-mysqli php7-imap php7-cgi \
    fcgi php7-pdo php7-pdo_mysql \
    php7-soap php7-xmlrpc php7-posix \
    php7-mcrypt php7-gettext php7-ldap \
    php7-ctype php7-dom php7 \
    php7-fpm php7-opcache php7-session

#download adminer
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

#rename
RUN mv adminer-4.8.1.php index.php

#execute on server, listen all, port default inside container
CMD php -S 0.0.0.0:8080
