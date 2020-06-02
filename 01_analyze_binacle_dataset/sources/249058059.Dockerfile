FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%commissaire-alpine:%%DOCKER_TAG%%

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        python3 && \
    apk add --no-cache --virtual build-deps \
        ca-certificates \
        openssl \
        tar && \
    export HARBOR_ETCD_COMPONENT=etcdctl && \
    wget https://github.com/coreos/etcd/releases/download/${HARBOR_ETCD_RELEASE_VERSION}/etcd-${HARBOR_ETCD_RELEASE_VERSION}-linux-amd64.tar.gz && \
    tar xzvf etcd-${HARBOR_ETCD_RELEASE_VERSION}-linux-amd64.tar.gz && \
    mv etcd-${HARBOR_ETCD_RELEASE_VERSION}-linux-amd64/${HARBOR_ETCD_COMPONENT} /bin/ && \
    apk del build-deps && \
    rm -Rf etcd-${HARBOR_ETCD_RELEASE_VERSION}-linux-amd64* && \
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
