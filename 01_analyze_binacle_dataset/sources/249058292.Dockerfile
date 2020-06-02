FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        nginx && \
    apk add --no-cache --virtual build-deps \
        docker

ENV DOCKER_HOST="172.17.0.1:2375"

ENV CLOUD_PLATFORM=openstack

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual openstack-build-deps \
        gcc \
        musl-dev \
        python-dev \
        linux-headers \
        openssl-dev && \
    python -m ensurepip && \
    pip --no-cache-dir install --upgrade pip setuptools && \
    pip --no-cache-dir install pbr && \
    pip --no-cache-dir install python-openstackclient && \
    apk del openstack-build-deps

RUN set -e && \
    set -x && \
    ( docker rm -f mandracchio-build-repo || true ) && \
      docker run \
        -d \
        -p 172.17.0.1:8012:80/tcp \
        --name mandracchio-build-repo \
        %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-repo:%%DOCKER_TAG%% && \
        ( docker rm -f mandracchio-build-installer || true ) && \
        docker run \
          -d \
          -p 172.17.0.1:8013:80/tcp \
          --name mandracchio-build-installer \
          %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-installer:%%DOCKER_TAG%% && \
    ( docker rm -f mandracchio-image-installer-setup || true ) && \
     docker run \
      --name=mandracchio-image-installer-setup \
      --net=host \
      --privileged \
      --pid=host \
      -v /dev:/dev:rw \
      -v /tmp:/tmp:rw \
      -v /srv:/srv:rw \
      -v /var/run:/var/run:rw \
      -v /var/lib/oz:/var/lib/oz:rw \
      -v /var/lib/imagefactory:/var/lib/imagefactory:rw \
      %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-images-assets:%%DOCKER_TAG%% /setup.sh

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    ( docker rm -f mandracchio-image-${CLOUD_PLATFORM}-build || true ) && \
     docker run \
      --name=mandracchio-image-${CLOUD_PLATFORM}-build \
      --net=host \
      --privileged \
      --pid=host \
      -v /dev:/dev:rw \
      -v /tmp:/tmp:rw \
      -v /srv:/srv:rw \
      -v /var/run:/var/run:rw \
      -v /var/lib/oz:/var/lib/oz:rw \
      -v /var/lib/imagefactory:/var/lib/imagefactory:rw \
      %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-images-assets:%%DOCKER_TAG%% /${CLOUD_PLATFORM}.sh

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    mkdir -p /srv/images && \
    docker cp mandracchio-image-${CLOUD_PLATFORM}-build:/srv/images/${CLOUD_PLATFORM} /srv/images

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
