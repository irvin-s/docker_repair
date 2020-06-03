FROM gliderlabs/logspout:master
ENV SYSLOG_FORMAT rfc3164

# Point it right at our ELK logstash host, which we alias via docker-compose.
ENV ROUTE_URIS=logstash://logstash:5000

# A little bit of metadata management.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.name="logspout-logstash" \
      org.label-schema.version=$VERSION \
      org.label-schema.description="This service pulls logs from docker containers and sends them to logstash." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.upstream.vcs-url="https://github.com/gliderlabs/logspout" \
      org.label-schema.upstream.vcs-ref="master" \
      org.label-schema.upstream.readme="https://github.com/looplab/logspout-logstash/blob/master/README.md"
