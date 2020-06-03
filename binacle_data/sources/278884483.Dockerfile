FROM amazonlinux:latest
MAINTAINER Letgo <sysops@letgo.com>

USER root

RUN yum -y install zip \
                   shadow-utils \
                   yum-plugin-ovl
RUN yum clean all && rm -fr /var/cache/*

ENV CONSUL_VERSION 0.9.3
ENV CONSUL_SHA256 9c6d652d772478d9ff44b6decdd87d980ae7e6f0167ad0f7bd408de32482f632

RUN yum install -y unzip

RUN curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o /tmp/consul.zip \
    && curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip -o /tmp/consul-ui.zip \
    && echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
    && sha256sum -c /tmp/consul.sha256 \
    && cd /bin \
    && mkdir ui \
    && unzip /tmp/consul.zip \
    && chmod +x /bin/consul \
    && rm /tmp/consul.zip 


ADD ./config /config/

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp
ENV DNS_RESOLVES consul
ENV DNS_PORT 8600

ENTRYPOINT ["/bin/consul", "agent", "-server", "-config-dir=/config", "--bootstrap"]

