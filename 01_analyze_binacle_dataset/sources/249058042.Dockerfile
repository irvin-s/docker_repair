FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="commissaire" \
    COMMISSAIRE_COMP="commissaire" \
    COMMISSAIRE_REPO_URL="https://github.com/portdirect/commissaire.git" \
    COMMISSAIRE_REPO_BRANCH="oslo" \
    COMMISSAIRE_SERVICE_COMP="commissaire-service" \
    COMMISSAIRE_SERVICE_REPO_URL="https://github.com/portdirect/commissaire-service.git" \
    COMMISSAIRE_SERVICE_REPO_BRANCH="ansible" \
    COMMISSAIRE_HTTP_COMP="commissaire-http" \
    COMMISSAIRE_HTTP_REPO_COMP="https://github.com/portdirect/commissaire-http.git" \
    COMMISSAIRE_HTTP_REPO_BRANCH="master" \
    COMMCTL_COMP="commctl" \
    COMMCTL_REPO_COMP="https://github.com/projectatomic/commctl.git" \
    COMMCTL_REPO_BRANCH="master"


RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        openssl \
        python3 && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        linux-headers \
        musl-dev \
        python3-dev \
        libffi-dev \
        openssl-dev && \
    python3 -m ensurepip && \
    pip3 --no-cache-dir install --upgrade pip setuptools && \
    pip3 --no-cache-dir install pyopenssl && \
    mkdir -p /opt/stack && \
    git clone ${COMMISSAIRE_REPO_URL} -b ${COMMISSAIRE_REPO_BRANCH} --depth 1 /opt/stack/${COMMISSAIRE_COMP} && \
    pip3 install -r /opt/stack/${COMMISSAIRE_COMP}/requirements.txt && \
    pip3 install /opt/stack/${COMMISSAIRE_COMP} && \
    apk del build-deps

COPY ./common-assets /opt/harbor/common-assets

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
