FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-repo-assets:%%DOCKER_TAG%%

ENV DOCKER_HOST="172.17.0.1:2375"

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* /

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
