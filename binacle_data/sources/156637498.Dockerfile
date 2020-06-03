FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install squid java-1.8.0-openjdk-devel make gcc-c++ git net-tools bash-completion vim wget cronie iptables; yum clean all

RUN cd /usr/local/src \
        && wget -c https://www.inet.no/$(curl -s https://www.inet.no/dante/download.html |grep HTTP |awk -F\" 'NR==1{print $2}') \
        && tar zxf dante-*.tar.gz \
        && cd dante-* \
        && ./configure && make && make install \
        && rm -rf /usr/local/src/*

RUN cd / && git clone https://github.com/chinashiyu/gfw.press.git

VOLUME /key

COPY gfw.press.sh /gfw.press.sh
RUN chmod +x /gfw.press.sh

WORKDIR /gfw.press

ENTRYPOINT ["/gfw.press.sh"]

EXPOSE 10001 10005

CMD ["gfw.press"]

# docker build -t gfw.press .
# docker run -d --restart always --privileged --network=host -e GFW_PASS=newpass -e GFW_EMOD=squid --hostname gfw.press --name gfw.press gfw.press
# docker logs gfw.press
