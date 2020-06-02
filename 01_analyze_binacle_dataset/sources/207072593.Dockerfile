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
      org.label-schema.name="alpine-keepalived" \
      org.label-schema.description="This service provides keepalived." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.ipvsadm="1.29-r0" \
      info.humanitarianresponse.keepalived=$VERSION

RUN apk update && \
    apk upgrade && \
    apk add \
        keepalived \
        # Bash allows us to monitor services via /dev/tcp :-) \
        bash \
        curl \
        mongodb-tools \
        mysql-client \
        postgresql-client \
        python3 \
        redis \
        && \
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
      ipvsadm \
        && \
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      docker \
        && \
    pip3 install --no-cache-dir docker-compose && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/keepalived", "-D", "-n"]

# Wants /etc/keepalived mounted as well as /dev/log and /var/run/docker.sock
