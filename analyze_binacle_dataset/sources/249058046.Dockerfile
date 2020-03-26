FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%commissaire-alpine:%%DOCKER_TAG%%

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        linux-headers \
        musl-dev \
        python3-dev \
        libffi-dev \
        openssl-dev && \
    mkdir -p /opt/stack && \
    git clone ${COMMCTL_REPO_COMP} -b ${COMMCTL_REPO_BRANCH} --depth 1 /opt/stack/${COMMCTL_COMP} && \
    pip3 install -r /opt/stack/${COMMCTL_COMP}/requirements.txt && \
    pip3 install /opt/stack/${COMMCTL_COMP} && \
    apk del build-deps

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
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
