FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine:%%DOCKER_TAG%%

ADD ./common-assets /opt/harbor/common-assets

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        docker \
        pwgen \
        util-linux && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${HARBOR_KUBE_RELEASE_VERSION}/bin/linux/amd64/kubectl > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    /bin/cp -rf /opt/harbor/common-assets/* / && \
    /bin/rm -rf /opt/harbor/common-assets && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    /bin/rm -rf /opt/harbor/assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
