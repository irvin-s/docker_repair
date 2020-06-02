FROM prom/prometheus

LABEL maintainer Peter Rossbach <peter.rossbach@bee42.com>

ARG "VERSION=0.1.0-dev"
ARG "BUILD_DATE=unknown"
ARG "VCS_URL=unknown"
ARG "VCS_REF=unkown"
ARG "VCS_BRANCH=unknown"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="Apache 2.0" \
      org.label-schema.name="prometheus" \
      org.label-schema.url="https://github.com/bee42/traefik-with-docker/" \
      org.label-schema.vcs-branch=$VCS_BRANCH \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-type="Git" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="bee42 solutions gmbh" \
      org.label-schema.description="Scrapes node-exporter, cadvisor, prometheus and swarm metrics (4999 port)." \
      org.label-schema.usage="examples/prometheus/README.md" \
      org.label-schema.url="https://github.com/bee42/traefik-with-docker/blob/master/examples/prometheus/README.md"

COPY etc /etc/prometheus
