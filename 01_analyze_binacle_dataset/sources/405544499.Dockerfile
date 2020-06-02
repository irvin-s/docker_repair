# base centos
FROM centos:7

# maintainer
MAINTAINER Peter Xu <peter@uskee.org>

# environments
RUN yum install -y libuuid libffi
RUN yum install -y glib2 openssl gnutls
RUN yum install -y net-tools
RUN yum clean all


COPY testing/routes.yml /tmp/etc/routes.yml
COPY testing/certs/key.pem /tmp/etc/cert.key
COPY testing/certs/cert.pem /tmp/etc/cert.pem
ADD xrtc /usr/bin/xrtc

EXPOSE 6000/udp 6080/tcp 6443/tcp

ADD testing/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/xrtc"]
