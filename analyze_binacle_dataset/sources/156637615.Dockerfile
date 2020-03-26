FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install squid java-1.8.0-openjdk-devel nmap-ncat net-tools bash-completion vim wget cronie iptables; yum clean all

RUN cd /usr/local/src \
        && wget -c http://apache.org/dist/zookeeper/stable/$(curl -s http://apache.org/dist/zookeeper/stable/ |grep tar.gz |awk -F\" 'NR==1{print $6}') \
        && tar zxf zookeeper-*.tar.gz \
        && \rm zookeeper-*.tar.gz \
        && mv zookeeper-* /usr/local/zookeeper

VOLUME /var/lib/zookeeper

COPY zookeeper.sh /zookeeper.sh
RUN chmod +x /zookeeper.sh

WORKDIR /usr/local/zookeeper

ENTRYPOINT ["/zookeeper.sh"]

EXPOSE 2181 2888 3888

CMD ["bin/zkServer.sh", "start-foreground"]

# docker build -t zookeeper .
# docker run -d --restart always -p 2181:2181 -v /docker/zookeeper:/var/lib/zookeeper --hostname zookeeper --name zookeeper zookeeper
# docker run -it --rm zookeeper --help
