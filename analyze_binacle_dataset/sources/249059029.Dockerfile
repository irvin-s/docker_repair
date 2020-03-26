FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-ubuntu:%%DOCKER_TAG%%

ENV OS_COMP="nova" \
    OS_REPO_URL="https://github.com/openstack/nova.git" \
    OS_REPO_BRANCH="stable/mitaka" \
    OS_COMP_1="nova-docker" \
    OS_REPO_URL_1="https://github.com/portdirect/nova-docker.git" \
    OS_REPO_BRANCH_1="master"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    apt-get update -y && \
    apt-get install --no-install-recommends -y \
        libxml2 \
        libxslt1.1 \
        openssl && \
    apt-get install --no-install-recommends -y \
        gcc \
        git \
        libffi-dev \
        python-dev \
        libpq-dev \
        libssl-dev \
        libxml2-dev \
        libxslt-dev && \
    /opt/harbor/build/dockerfile.sh && \
    APT_LAST_INSTALLED=$(awk '!/^Start|^Commandl|^End|^Upgrade:|^Error:/ { gsub( /\([^()]*\)/ ,"" );gsub(/ ,/," ");sub(/^Install:/,""); print}' /var/log/apt/history.log | tail -n 1) && \
    apt-get remove -y ${APT_LAST_INSTALLED} && \
    apt-get clean all


LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
