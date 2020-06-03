FROM registry.access.redhat.com/rhel7:latest
LABEL maintainer="Micah Abbott <miabbott@redhat.com>" \
      version=1.0

ENV container docker

ADD makecache.sh /

RUN /makecache.sh && \
    yum install --disablerepo=\* \
                --enablerepo=rhel-7-server-rpms \
                -y httpd && \
    yum clean all && \
    systemctl enable httpd

STOPSIGNAL SIGRTMIN+3
EXPOSE 80

ENTRYPOINT [ "/sbin/init" ]
