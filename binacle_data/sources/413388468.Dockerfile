# Alpine BASE_IMAGE=3.7 installs keepalived 1.3
# Alpine BASE_IMAGE=3.8 installs keepalived 2.0
ARG BASE_IMAGE=3.7

LABEL architecture="x86_64"                       \
      license="MIT"                               \
      name="kalise/keepalived"                    \
      summary="Alpine based keepalived container" \
      version="$VERSION"                          \
      mantainer="kalise"                          \
      url="https://github.com/kalise/keepalived"

FROM alpine:$BASE_IMAGE

RUN apk add --no-cache \
    curl       \
    keepalived \
    && rm -f /etc/keepalived/keepalived.conf

ENTRYPOINT ["/usr/sbin/keepalived", "-nlDP"]