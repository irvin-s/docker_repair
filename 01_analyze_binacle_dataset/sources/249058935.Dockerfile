FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-cinder-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="cinder-init"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual build-deps \
        gcc \
        musl-dev \
        python-dev \
        linux-headers \
        openssl-dev && \
    mkdir -p /opt/stack && \
    pip --no-cache-dir install python-openstackclient && \
    apk del build-deps && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
