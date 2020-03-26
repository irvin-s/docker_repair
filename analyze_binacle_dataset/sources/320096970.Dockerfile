FROM dockette/alpine:3.6

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apk update && \
    apk upgrade && \
    apk --no-cache add graphviz git php7 && \
    git clone https://github.com/jakobwesthoff/phuml.git /tmp/phuml && \
    mv /tmp/phuml/src /srv/phuml && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ENTRYPOINT ["/srv/phuml/app/phuml"]
CMD ["-h"]
