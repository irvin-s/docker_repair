FROM python:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV CURATOR_VERSION ${VERSION}

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="curator" \
      org.label-schema.description="This service provides the elasticsearch curator." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Debian Linux" \
      org.label-schema.distribution-version="9.5" \
      info.humanitarianresponse.curator=${VERSION}

RUN apt-get update && \
      apt-get install apt-transport-https gnupg wget -y && \
      wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian9 stable main" | tee -a /etc/apt/sources.list.d/curator.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install elasticsearch-curator=${CURATOR_VERSION} -y && \
    apt-get remove --purge wget gnupg apt-transport-https -y && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT [ "/usr/bin/curator", "--config", "/etc/curator/curator.yml" ]
