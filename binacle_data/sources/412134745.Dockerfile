### Dockerfile
#
#   See https://github.com/russmckendrick/docker
#
FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>
ENV CONSUL_VERSION 0.6.4
ENV CONSUL_SHA256 abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627
ENV CONSUL_UI_SHA256 5f8841b51e0e3e2eb1f1dc66a47310ae42b0448e77df14c83bb49e0e0d5fa4b7
RUN  apk add --update wget \
  && wget -O consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip \
  && echo "$CONSUL_SHA256 *consul.zip" | sha256sum -c - \
  && unzip consul.zip \
  && mv consul /bin/ \
  && rm -rf consul.zip \
  && cd /tmp \
  && wget -O ui.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip \
  && echo "$CONSUL_UI_SHA256 *ui.zip" | sha256sum -c - \
  && unzip ui.zip \
  && mkdir -p /ui \
  && mv * /ui \
  && rm -rf /tmp/* /var/cache/apk/*
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp
VOLUME [ "/data" ]
ENTRYPOINT [ "/bin/consul" ]
CMD [ "agent", "-data-dir", "/data", "-server", "-bootstrap-expect", "1", "-ui-dir", "/ui", "-client=0.0.0.0"]