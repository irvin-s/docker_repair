FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%freeipa-client:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="marina"

RUN set -e && \
    set -x && \
    dnf install -y \
        pwgen \
        git && \
    dnf clean all && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${HARBOR_KUBE_RELEASE_VERSION}/bin/linux/amd64/kubectl > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    container-base-systemd-reset.sh


COPY ./common-assets/ /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
