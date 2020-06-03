FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%centos:%%DOCKER_TAG%%

ENV OS_COMP="designate" \
    HARBOR_COMPONENT="powerdns"

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    yum install -y \
        pdns \
        pdns-backend-mysql \
        bind-utils && \
	  yum clean all && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
