FROM docker.io/alpine:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.1
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

COPY Dockerfile /

# The origin version of this Dockerfile was based on the alpine image ID
# 4ccfa836b1ef (created June 2, 2016) which had some sort of problem where
# there is no 'apache2' group defined.  As such, the 'httpd.conf' file had
# to be modified.  I'll leave it as is since it doesn't seem to affect the
# ability to run the container.
RUN apk --update add apache2 && \
    echo "SUCCESS alpine_httpd" > /var/www/localhost/htdocs/index.html && \
    mkdir -p /run/apache2/ && \
    sed -i 's/Group apache/Group www-data/' /etc/apache2/httpd.conf

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
