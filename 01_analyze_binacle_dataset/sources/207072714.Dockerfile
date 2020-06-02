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
      org.label-schema.name="alpine-varnish" \
      org.label-schema.description="This service provides a varnish platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.varnish=$VERSION

ENV DAEMON_USER=varnish \
    LISTEN_ADDR=0.0.0.0 \
    LISTEN_PORT=80 \
    CONFIG_FILE=/etc/varnish/default.vcl \
    STORAGE_BACKEND=malloc,128M \
    # Extra options to pass to the varnish daemon.
    VARNISHD_OPTS=

COPY run_varnish default.vcl /

RUN apk add --update-cache varnish && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/services.d/varnish /etc/varnish && \
    mv /run_varnish /etc/services.d/varnish/run && \
    mv /default.vcl /etc/varnish/ && \
    chown -R varnish:varnish /etc/varnish

VOLUME ["/etc/varnish"]

EXPOSE 80 6082

