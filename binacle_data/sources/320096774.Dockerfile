FROM dockette/edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apk update && \
    apk upgrade && \
    apk --no-cache add hugo && \
    rm -rf /var/cache/apk/*

WORKDIR /srv

ENTRYPOINT ["/usr/bin/hugo"]
