FROM registry.access.redhat.com/rhel7-atomic:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.0
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

COPY Dockerfile /root/

RUN microdnf --enablerepo=rhel-7-server-rpms \
			 install httpd && \
    microdnf clean all

RUN echo "SUCCESS rhel7-atomic_httpd" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
