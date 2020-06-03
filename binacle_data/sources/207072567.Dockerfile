FROM unocha/alpine-base:%%UPSTREAM%%

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ARG S6_VERSION=v1.21.4.0

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="base-s6" \
      org.label-schema.description="This service provides a base Alpine Linux container." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version=$VERSION \
      org.label-schema.s6-version=$S6_VERSION

RUN curl -sL https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz -o /tmp/s6.tgz && \
    tar xzf /tmp/s6.tgz -C / && \
    rm -f /tmp/s6.tgz

ENTRYPOINT ["/init"]

CMD []
