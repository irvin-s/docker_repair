FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-raven:%%DOCKER_TAG%%

ENV OS_COMP="raven-watcher-namespace" \
    RAVEN_SINGLE_SHOT="True"

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
