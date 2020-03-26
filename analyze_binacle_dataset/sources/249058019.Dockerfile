FROM alpine:latest

MAINTAINER Port Direct <support@port.direct>

ENV OS_DISTRO="HarborOS-Alpine" \
    container=docker \
    OS_REPO_BRANCH="master" \
    HARBOR_ETCD_RELEASE_VERSION="v3.0.4" \
    HARBOR_KUBE_RELEASE_VERSION="v1.3.6" \
    HARBOR_ALPINE_BIND_VERSION="9.10.4-P2"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    apk upgrade --no-cache && \
    apk add --no-cache --virtual base-deps \
        findutils \
        curl \
        bash && \
    apk add --no-cache --virtual build-deps \
        linux-headers \
        alpine-sdk && \
    cd /tmp && \
    curl ftp://ftp.isc.org/isc/bind9/${HARBOR_ALPINE_BIND_VERSION}/bind-${HARBOR_ALPINE_BIND_VERSION}.tar.gz|tar -xzv && \
    cd /tmp/bind-${HARBOR_ALPINE_BIND_VERSION} && \
      CFLAGS="-static" ./configure --without-openssl --disable-symtable  && \
      make && \
      cp ./bin/dig/dig /usr/bin/ && \
      cd / && \
    rm -rf /tmp/bind-${HARBOR_ALPINE_BIND_VERSION}/ && \
    apk del build-deps && \
    mkdir -p /var/run/harbor/secrets

ENTRYPOINT ["/init"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
