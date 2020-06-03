FROM elasticsearch:%%UPSTREAM%%

ENV CURATOR_VERSION 4.1.2
ENV CURATOR_REPO_BASE http://packages.elastic.co/curator/4/debian
ENV BEATS_VERSION %%UPSTREAM%%
ENV BEATS_REPO_BASE https://artifacts.elastic.co/downloads/beats

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="elasticsearch" \
      org.label-schema.description="This service provides elasticsearch." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Debian Linux" \
      org.label-schema.distribution-version="8.5" \
      info.humanitarianresponse.es=${BEATS_VERSION} \
      info.humanitarianresponse.curator=${CURATOR_VERSION} \
      info.humanitarianresponse.beats=${BEATS_VERSION}

RUN echo "deb $CURATOR_REPO_BASE stable main" > /etc/apt/sources.list.d/curator.list

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      python-elasticsearch-curator=${CURATOR_VERSION} \
      python-setuptools \
      libpcap0.8 && \
    cd /tmp && \
    curl -L -O ${BEATS_REPO_BASE}/filebeat/filebeat-${BEATS_VERSION}-amd64.deb && \
    curl -L -O ${BEATS_REPO_BASE}/metricbeat/metricbeat-${BEATS_VERSION}-amd64.deb && \
    curl -L -O ${BEATS_REPO_BASE}/packetbeat/packetbeat-${BEATS_VERSION}-amd64.deb && \
    dpkg -i filebeat-${BEATS_VERSION}-amd64.deb && \
    dpkg -i metricbeat-${BEATS_VERSION}-amd64.deb && \
    dpkg -i packetbeat-${BEATS_VERSION}-amd64.deb && \
    rm -r /tmp/*.deb && \
    rm -rf /var/lib/apt/lists/*

COPY load_beats_templates.sh /usr/local/bin/
COPY load_beats_dashboards.sh /usr/local/bin/
