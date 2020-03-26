FROM registry.access.redhat.com/rhel7:latest
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.3
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

COPY Dockerfile /root/
COPY makecache.sh /root/

RUN /root/makecache.sh && \
    yum install \
        --disablerepo=\* \
        --enablerepo=rhel-7-server-rpms \
        -y httpd && \
    yum clean all

RUN echo "SUCCESS rhel7_httpd" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
