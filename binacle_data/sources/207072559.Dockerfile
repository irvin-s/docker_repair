FROM unocha/alpine-base-s6:%%UPSTREAM%%

MAINTAINER "Serban TEODORESCU <teodorescu.serban@gmail.com>"

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
      org.label-schema.name="alpine-base-redis" \
      org.label-schema.description="This service provides a base redis platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.redis=$VERSION

RUN apk add --update-cache redis && \
    rm -rf /var/cache/apk/*
