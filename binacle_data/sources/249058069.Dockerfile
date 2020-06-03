FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%commissaire-service:%%DOCKER_TAG%%

COPY ./assets /opt/harbor/assets

RUN cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

ENTRYPOINT ["/usr/bin/commissaire-storage-service"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
