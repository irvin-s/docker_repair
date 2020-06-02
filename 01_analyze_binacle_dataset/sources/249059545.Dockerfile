FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-heat-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="heat-engine" \
    OS_COMP_1="heat-docker" \
    OS_REPO_URL_1="https://github.com/portdirect/heat.git" \
    OS_REPO_BRANCH_1="master"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    apk add --no-cache --virtual build-deps \
        git && \
    /opt/harbor/build/dockerfile.sh && \
    apk del build-deps && \
    pip --no-cache-dir install docker-py

USER heat
 
LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
