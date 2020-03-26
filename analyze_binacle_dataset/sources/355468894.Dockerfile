FROM ubuntu
MAINTAINER Andrew Pennebaker <andrew.pennebaker@gmail.com>
ADD http://archive.ubuntu.com/ubuntu/dists/trusty-updates/main/installer-amd64/current/images/netboot/netboot.tar.gz /netboot.tar.gz
RUN apt-get update && \
    apt-get install -y dnsmasq tar && \
    mkdir /tftpboot && \
    tar -C /tftpboot -xvf /netboot.tar.gz && \
    chown -R nobody:nogroup /tftpboot
COPY dnsmasq.conf /etc/dnsmasq.conf
EXPOSE 69/udp
ENTRYPOINT ["/usr/sbin/dnsmasq", "-k"]
