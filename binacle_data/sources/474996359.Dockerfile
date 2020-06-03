FROM docker.io/nginx:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.0
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

RUN echo "SUCCESS nginx_httpd" > /usr/share/nginx/html/index.html

EXPOSE 80
