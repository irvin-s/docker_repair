FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN curl http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest -o /etc/delegated-apnic-latest
RUN curl https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo -o /etc/yum.repos.d/librehat-shadowsocks-epel-7.repo
RUN yum clean all; yum -y install epel-release; yum -y update \
        && yum -y install net-tools iproute bash-completion vim wget openssl bind-utils iptables cronie shadowsocks-libev ipset ipset-libs \
        && yum clean all

VOLUME /key

COPY ssserver.sh /ssserver.sh
RUN chmod +x /ssserver.sh

EXPOSE 8443

ENTRYPOINT ["/ssserver.sh"]

CMD ["shadowsocks"]

# docker build -t shadowsocks .
# docker run -d --restart always -p 8443:8443 --hostname shadowsocks --name shadowsocks shadowsocks
# docker logs shadowsocks
