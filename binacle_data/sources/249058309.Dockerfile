FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        nginx && \
    apk add --no-cache --virtual build-deps \
        docker

ENV DOCKER_HOST="172.17.0.1:2375"

RUN ( docker rm -f mandracchio-build-rpms || true ) && \
      docker run \
        -d \
        -p 172.17.0.1:81:80/tcp \
        --name mandracchio-build-rpms \
        %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-rpms:%%DOCKER_TAG%% && \
      ( docker rm -f mandracchio-build-repo || true ) && \
      docker run \
        -d \
        -p 172.17.0.1:8012:80/tcp \
        --name mandracchio-build-repo \
        %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-repo:%%DOCKER_TAG%%

RUN  ( docker rm -f mandracchio-image-installer-setup || true ) && \
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

RUN  ( docker rm -f mandracchio-image-installer-build || true ) && \
     docker run \
      --name=mandracchio-image-installer-build \
      --net=host \
      --privileged \
      --pid=host \
      -v /dev:/dev:rw \
      -v /tmp:/tmp:rw \
      -v /srv:/srv:rw \
      -v /var/run:/var/run:rw \
      -v /var/lib/oz:/var/lib/oz:rw \
      -v /var/lib/imagefactory:/var/lib/imagefactory:rw \
      %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%mandracchio-images-assets:%%DOCKER_TAG%% /installer.sh

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    mkdir -p /srv/images && \
    docker cp mandracchio-image-installer-build:/srv/images/installer /srv/images

CMD ["/start.sh"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
