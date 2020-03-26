FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum -y install epel-release; yum -y update; yum -y install strongswan xl2tpd openssl iptables cronie net-tools bash-completion vim; yum clean all

VOLUME /key

COPY strongswan.sh /strongswan.sh
RUN chmod +x /strongswan.sh

WORKDIR /usr/sbin

ENTRYPOINT ["/strongswan.sh"]

EXPOSE 500/udp 4500/udp 1701/udp

CMD ["strongswan", "start", "--nofork"]

# docker build -t strongswan .
# docker run -d --restart always --privileged -v /docker/strongswan:/key --network=host -e VPN_PASS=123456 --hostname strongswan --name strongswan strongswan
# cat /docker/strongswan/strongswan.log
