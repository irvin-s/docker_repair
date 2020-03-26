FROM debian:%%UPSTREAM%%

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
      org.label-schema.name="base" \
      org.label-schema.description="This service provides a base Debian Linux container." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Debian Linux" \
      org.label-schema.distribution-version=$VERSION

ENV APPUSER_GID=4000 \
    APPUSER_UID=4000 \
    DEBIAN_FRONTEND=noninteractive \
    TERM=xterm

RUN apt-get -qy update && \
    apt-get -qy install \
        apt-utils && \
    apt-get -qy upgrade && \
    apt-get -qy install \
        curl \
        nano && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /src/*.deb && \
    groupadd --system -g $APPUSER_GID appuser && \
    useradd --system -u $APPUSER_UID -s /sbin/nologin -c 'Docker App User' \
        -d /home/appuser -g appuser -m appuser
