FROM alpine:%%UPSTREAM%%

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
      org.label-schema.description="This service provides a base Alpine Linux container." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version=$VERSION

# Default user id and group id.
# a good idea from orakili <docker@orakili.net>
ENV APPUSER_GID=4000 \
    APPUSER_UID=4000

RUN apk update && \
    apk upgrade && \
    apk add --update-cache curl \
        nano && \
    rm -rf /var/cache/apk/* && \
    addgroup -g $APPUSER_GID -S appuser && \
    adduser -u $APPUSER_UID -s /sbin/nologin -g 'Docker App User' -h /home/appuser -D -G appuser appuser
