FROM gcr.io/google_containers/nginx-ingress-controller:0.8.3

MAINTAINER Pete Birley <petebirley@gmail.com>

ENV OS_DISTRO="HarborOS"

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/assets/* /

ENTRYPOINT ["/start.sh"]

CMD []

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
