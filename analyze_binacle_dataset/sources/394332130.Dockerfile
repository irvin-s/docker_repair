## Dockerfile that generates an instance of http://bencane.com

FROM nginx:latest
MAINTAINER Benjamin Cane <ben@bencane.com>

## NGINX custom config
RUN mkdir -p /etc/nginx/globals && rm -vf /etc/nginx/sites-enabled/*
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/htmlglobal.conf /etc/nginx/globals/
COPY nginx/bencane.com.conf /etc/nginx/sites-enabled/

## Install python and pip
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Create a directory for required files
RUN mkdir -p /build/

## Install Hugo
RUN cd / && curl -L https://github.com/gohugoio/hugo/releases/download/v0.46/hugo_0.46_Linux-64bit.tar.gz | tar -xvzf-

## Add blog code nd required files
ADD bencane /bencane

## Run Generator
RUN cd /bencane && /hugo -d /usr/share/nginx/html
RUN mkdir -p /usr/share/nginx/html/feed && mv /usr/share/nginx/html/post/index.xml /usr/share/nginx/html/feed/
RUN find /usr/share/nginx/html -type f -name "index.xml" | grep -v feed | xargs rm -f
RUN perl -pi -e 's/post\/index.xml/feed/' /usr/share/nginx/html/feed/index.xml
