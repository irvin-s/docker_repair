FROM centos:latest
MAINTAINER Port Direct <support@port.direct>

ENV OS_DISTRO="HarborOS" \
    OPENSTACK_COMPONENT="mandracchio-assets" \
    LC_ALL="en_US.UTF-8" \
    container=docker

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor"

ADD ./assets/etc /opt/harbor/assets/etc

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    yum install -y \
        rpm-ostree-toolbox && \
    yum clean all


ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    ostree --repo=/srv/repo init --mode=archive-z2

CMD ["/start.sh"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
