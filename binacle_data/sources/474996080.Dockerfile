FROM registry.fedoraproject.org/fedora:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.2
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

ADD makecache.sh /

RUN /makecache.sh && \
    dnf -y install httpd && \
    dnf clean all

RUN echo "SUCCESS fedora_httpd" > /var/www/html/index.html
EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
