FROM registry.access.redhat.com/rhel6
MAINTAINER Micah Abbott <micah@redhat.com>

LABEL Version=1.2
LABEL RUN="docker run -d --name NAME -p 80:80 IMAGE"

ENV container docker

COPY Dockerfile /root/
COPY makecache.sh /root/

RUN /root/makecache.sh && \
    yum install \
        --disablerepo=\* \
        --enablerepo=rhel-6-server-rpms \
        -y httpd && \
    yum clean all

RUN echo "SUCCESS rhel6_httpd" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
