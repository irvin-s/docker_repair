FROM alpine:3.3

MAINTAINER Péter Szilágyi <peterke@gmail.com>

# Install any runtime dependencies
RUN \
  apk add --update ffmpeg bash && \
  rm -rf /var/cache/apk/*

# Install the media source extension patcher
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH

RUN \
  apk add --update go git                               && \
  go get github.com/acolwell/mse-tools/mse_webm_remuxer && \
  apk del go git                                        && \
  rm -rf /var/cache/apk/*

# Prep the image for encoding
ADD encode.sh encode.sh
RUN chmod +x encode.sh

ENTRYPOINT ["/encode.sh"]
