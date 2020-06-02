FROM alpine:3.7

ENV CONSUL_VERSION="1.2.0" \
  CONSUL_CHECKSUM="85d84ea3f6c68d52549a29b00fd0035f72c2eabff672ae46ca643cb407ef94b4"

RUN apk --no-cache add postgresql-client curl unzip ca-certificates libcap-ng-utils && \
  curl -Lo /tmp/consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
  echo "${CONSUL_CHECKSUM}  /tmp/consul.zip" | sha256sum -c - && \
  unzip -d /usr/bin/ /tmp/consul.zip && \
  rm /tmp/consul.zip && \
  apk del --no-cache unzip && \
  filecap /usr/bin/consul net_bind_service && \
  addgroup -S consul && \
  adduser -h /tmp -G consul -DHS consul && \
  install -d -o consul -g consul /tmp/state /tmp/server /tmp/db /tmp/client && \
  apk --no-cache del unzip libcap-ng-utils

ADD config/consul_config.hcl /tmp/db/
ADD config/consul_config.hcl /tmp/client/
ADD config/consul_config.hcl /tmp/server/
ADD config/db_service.hcl /tmp/db/
ADD config/client_service.hcl /tmp/client/

USER consul
ENTRYPOINT ["/usr/bin/consul"]
