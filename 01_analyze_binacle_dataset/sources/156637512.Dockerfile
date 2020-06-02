FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install squid java-1.8.0-openjdk-devel nmap-ncat net-tools bash-completion vim wget cronie at iptables; yum clean all

RUN cd /usr/local/src \
        && kafka_v=$(curl -s https://kafka.apache.org/downloads |grep '<h3>' |head -1 |grep -Po '(?<=\>)[^)]*(?=\<)') \
        && kafka_f=$(curl -s http://apache.org/dist/kafka/$kafka_v/ |grep 'tgz</a>' |tail -1 |awk -F\" '{print $6}') \
        && wget -c http://apache.org/dist/kafka/$kafka_v/$kafka_f \
        && tar xf kafka_*.tgz \
        && \rm kafka_*.tgz \
        && mv kafka_* /usr/local/kafka

VOLUME /tmp/kafka-logs

COPY kafka.sh /kafka.sh
RUN chmod +x /kafka.sh

WORKDIR /usr/local/kafka

ENTRYPOINT ["/kafka.sh"]

EXPOSE 9092

CMD ["bin/kafka-server-start.sh", "config/server.properties"]

# docker build -t kafka .
# docker run -d --restart always --network=mynetwork --ip=10.0.0.100 -p 9092:9092 -v /docker/kafka:/var/lib/kafka-logs -e ZK_SERVER=10.0.0.70:2181 -e KK_TOPIC=test:1:1 --hostname kafka --name kafka kafka
# docker run -it --rm kafka --help
