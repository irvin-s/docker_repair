FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%cockpit-systemd:%%DOCKER_TAG%%


COPY ./common-assets/ /opt/harbor/common-assets

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    dnf install -y \
        docker-engine \
        git && \
    dnf clean all && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${HARBOR_KUBE_RELEASE_VERSION}/bin/linux/amd64/kubectl > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    kubectl completion bash > /etc/bash_completion.d/kubectl && \
    chmod +x /etc/bash_completion.d/kubectl && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    /bin/rm -rf /opt/harbor/assets && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    container-base-systemd-reset.sh && \
    rm -f /init-ipa


LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
