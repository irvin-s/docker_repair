FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

ENV OS_COMP="raven" \
    OS_REPO_URL="https://github.com/portdirect/kuryr.git" \
    OS_REPO_BRANCH="k8s"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    apk add --no-cache --virtual run-deps \
        python3 && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        linux-headers \
        musl-dev \
        python3-dev && \
    python3 -m ensurepip && \
    pip3 --no-cache-dir install --upgrade pip setuptools && \
    git clone -b ${OS_REPO_BRANCH} --depth 1 ${OS_REPO_URL} /opt/${OS_COMP} && \
    pip3 --no-cache-dir install /opt/${OS_COMP} && \
    mkdir -p /etc/${OS_COMP} && \
    cp /opt/${OS_COMP}/etc/raven.conf.sample /etc/${OS_COMP}/raven.conf && \
    mkdir -p /var/log/raven && \
    addgroup kuryr -g 1000 && \
    adduser -u 1000 -D -s /bin/false -G kuryr ${OS_COMP} && \
    apk del build-deps

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
