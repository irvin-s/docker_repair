FROM logstash:%%UPSTREAM%%

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
      org.label-schema.name="logstash" \
      org.label-schema.description="This service provides logstash." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Debian Linux" \
      org.label-schema.distribution-version="8.5" \
      info.humanitarianresponse.logstash=${VERSION}

COPY docker-entrypoint.sh /

# IF needed
RUN logstash-plugin update
