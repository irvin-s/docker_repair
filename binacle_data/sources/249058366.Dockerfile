FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        nginx && \
    apk add --no-cache --virtual build-deps \
        docker

ENV DOCKER_HOST="172.17.0.1:2375"

LABEL build-uuid="%%BUILD_UUID%%"

RUN set -e && \
    set -x && \
    ( docker rm -f mandracchio-build-repo || true ) && \
    docker run \
      -t \
      --name mandracchio-build-repo \
      --privileged \
      port/mandracchio-repo-assets:latest /build.sh && \
    ( docker rm -f mandracchio-build-rpms || true ) && \
    docker cp mandracchio-build-repo:/srv/repo /srv && \
    ls -lah /srv/repo/refs/heads/harbor-host/7/x86_64/standard

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* /

CMD ["/start.sh"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
