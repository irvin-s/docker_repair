FROM amazonlinux:latest
MAINTAINER Letgo <sysops@letgo.com>

USER root

RUN yum -y install zip \
                   shadow-utils 

ENV CONSUL_VERSION 0.9.3
ENV CONSUL_SHA256 9c6d652d772478d9ff44b6decdd87d980ae7e6f0167ad0f7bd408de32482f632

RUN yum install -y unzip telnet

RUN curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o /tmp/consul.zip \
    && echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
    && sha256sum -c /tmp/consul.sha256 \
    && cd /bin \
    && unzip /tmp/consul.zip \
    && chmod +x /bin/consul \
    && rm /tmp/consul.zip

RUN yum install -y https://github.com/sysown/proxysql/releases/download/v1.3.8/proxysql-1.3.8-1-centos67.x86_64.rpm \
    procps \
    mysql  


ADD ./consul-agent /config/
ADD ./scripts/run_both_process.sh /root/

RUN chmod 755 /root/run_both_process.sh

COPY proxysql.cnf /etc/proxysql.cnf

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp 6032 6033
ENV DNS_RESOLVES consul
ENV DNS_PORT 8600


CMD ["sh","/root/run_both_process.sh"]
