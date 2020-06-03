FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine-common-deps:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="init"

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        openssl \
        ansible

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
