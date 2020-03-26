FROM unocha/alpine-base-s6:%%UPSTREAM%%

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

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
      org.label-schema.name="alpine-redis" \
      org.label-schema.description="This service provides a memcached platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.memcached=$VERSION

ENV LANG=en_US.utf8 \
    MEMCACHE_PORT=11211 \
    MEMCACHE_MAX_MEMORY=1024 \
    MEMCACHE_SLAB_SIZE=1M \
    MEMCACHE_USER=memcached

COPY run_memcache /

RUN apk add --update-cache \
        memcached \
        && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/memcache && \
    mv /run_memcache /etc/services.d/memcache/run

EXPOSE 11211
