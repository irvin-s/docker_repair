FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="nginx"

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        nginx && \
    apk add --no-cache --virtual build-deps \
        git && \
    git clone --depth 1 --branch gh-pages https://github.com/portdirect/server-error-pages /opt/server-error-pages && \
    cp -rf /opt/server-error-pages/_site/*.html /srv/ && \
      /bin/bash -c "set -e && set -x && cd /srv && for file in *-error.html; do mv \"\$file\" \"\${file%-error.html}.html\"; done" && \
    rm -rf /opt/server-error-pages && \
    apk del build-deps && \
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
