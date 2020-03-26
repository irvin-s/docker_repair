FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine:%%DOCKER_TAG%%

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"

ENV OS_COMP="openstackclient" \
    OS_CLIENT="openstack"

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual build-deps \
        gcc \
        musl-dev \
        python-dev \
        linux-headers \
        openssl-dev && \
    mkdir -p /opt/stack && \
    pip --no-cache-dir install pbr && \
    pip --no-cache-dir install python-${OS_COMP} && \
    apk del build-deps && \
    mkdir -p /var/log/${OS_CLIENT} && \
    addgroup ${OS_CLIENT} -g 1000 && \
    adduser -u 1000 -D -s /bin/false -G ${OS_CLIENT} ${OS_CLIENT} && \
    chown -R ${OS_CLIENT}:${OS_CLIENT} /var/log/${OS_CLIENT} && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

USER openstack
