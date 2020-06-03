FROM docker.io/ubuntu:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.3
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

COPY Dockerfile /root/

RUN apt-get update && \
    apt-get -y install apache2 && \
    apt-get clean

RUN echo "SUCCESS ubuntu_httpd" > /var/www/html/index.html

# Copy in special script to remove existing PID file and start httpd
# https://github.com/docker-library/php/pull/59
COPY apache2-foreground /usr/local/bin/

EXPOSE 80

ENTRYPOINT [ "/usr/local/bin/apache2-foreground" ]
