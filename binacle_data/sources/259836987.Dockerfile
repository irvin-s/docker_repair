FROM centos:latest

RUN yum install -y tftp-server syslinux wget
RUN mkdir /srv/tftpboot
ADD tramp /srv/tftpboot

ENV LISTEN_IP=0.0.0.0
ENV LISTEN_PORT=69

ENTRYPOINT in.tftpd -s /srv/tftpboot -4 -L -a $LISTEN_IP:$LISTEN_PORT
