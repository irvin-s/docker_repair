FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-gnocchi-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="gnocchi-api"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        musl-dev \
        linux-headers \
        python-dev && \
    pip --no-cache-dir install uwsgi && \
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
