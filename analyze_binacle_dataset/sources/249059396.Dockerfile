FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="rabbitmq" \
    RABBITMQ_VERSION=3.6.5

COPY ./assets /opt/harbor/assets

RUN dnf install -y \
        erlang-asn1 \
        erlang-compiler \
        erlang-crypto \
        erlang-erts \
        erlang-hipe \
        erlang-inets \
        erlang-kernel \
        erlang-mnesia \
        erlang-eldap \
        erlang-os_mon \
        erlang-otp_mibs \
        erlang-public_key \
        erlang-runtime_tools \
        erlang-sasl \
        erlang-sd_notify \
        erlang-snmp \
        erlang-ssl \
        erlang-stdlib \
        erlang-syntax_tools \
        erlang-tools \
        erlang-xmerl \
        lksctp-tools \
        logrotate \
        make \
        openssl \
        curl \
        tar \
        xz \
        hostname && \
    dnf clean all && \
    curl -sSL https://www.rabbitmq.com/releases/rabbitmq-server/v${RABBITMQ_VERSION}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.xz | tar -xJ -C / --strip-components 1 && \
    rm -rf /share/**/rabbitmq*.xz && \
    groupadd rabbitmq -g 1000 && \
    adduser -u 1000 -g rabbitmq --system rabbitmq && \
    mkdir -p /home/rabbitmq && \
    chown rabbitmq:rabbitmq /home/rabbitmq && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
