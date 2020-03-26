FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-gnocchi-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="gnocchi-init"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps  \
        util-linux && \
    addgroup grafana -g 994 && \
    adduser -u 995 -D -s /bin/false -G grafana grafana && \
    mkdir -p /usr/share/grafana && \
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
