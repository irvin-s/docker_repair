FROM docker.io/httpd:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.0
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

RUN echo "SUCCESS apache_httpd" > /usr/local/apache2/htdocs/index.html

EXPOSE 80
