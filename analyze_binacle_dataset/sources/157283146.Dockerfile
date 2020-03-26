FROM richarvey/nginx-php-fpm:latest

MAINTAINER janes <miscjanes@gmail.com>

RUN apt-get update \
    && apt-get install -y libssh-dev \
    && rm -rf /var/lib/apt/lists/*
    
COPY code/ /usr/share/nginx/html