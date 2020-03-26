FROM docker.io/busybox:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.0
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

COPY Dockerfile /

RUN mkdir /www && echo "SUCCESS busybox_httpd" > /www/index.html

EXPOSE 80

ENTRYPOINT [ "/bin/httpd" ]
CMD [ "-f", "-h", "/www", "-p", "80" ]
