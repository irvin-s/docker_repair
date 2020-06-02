FROM debian:jessie
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>
RUN apt-get update
RUN apt-get install dnsmasq -y
RUN mkdir -p /var/lib/tftpboot
ENTRYPOINT ["/usr/sbin/dnsmasq", "-d", "-C", "/etc/dnsmasq.conf"]
