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
    git clone ${COMMISSAIRE_HTTP_REPO_COMP} -b ${COMMISSAIRE_HTTP_REPO_BRANCH} --depth 1 /opt/stack/${COMMISSAIRE_HTTP_COMP} && \
    pip3 install -r /opt/stack/${COMMISSAIRE_HTTP_COMP}/requirements.txt && \
    pip3 install /opt/stack/${COMMISSAIRE_HTTP_COMP} && \
    mkdir -p /etc/commissaire && \
    cp -av /opt/stack/${COMMISSAIRE_HTTP_COMP}/conf/users.json /etc/commissaire/users.json && \
    apk del build-deps

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

ENTRYPOINT ["/usr/bin/commissaire-server"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
