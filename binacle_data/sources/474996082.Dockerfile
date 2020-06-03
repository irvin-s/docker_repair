FROM registry.fedoraproject.org/fedora:latest
LABEL maintainer="Micah Abbott <miabbott@redhat.com>" \
      version=1.0

ENV container docker

ADD makecache.sh /

RUN /makecache.sh && \
    dnf -y install httpd && \
    dnf clean all && \
    systemctl enable httpd

STOPSIGNAL SIGRTMIN+3
EXPOSE 80

ENTRYPOINT [ "/sbin/init" ]
