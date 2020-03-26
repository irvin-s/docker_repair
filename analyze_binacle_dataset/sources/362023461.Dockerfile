FROM golang:1.7

ARG APP_VERSION=0.0.0
ARG APP_REVISION=unknown
ENV SOUS_RUN_IMAGE_SPEC=/runspec.json

COPY . /go/src/github.com/opentable/sous-demo
RUN \
  cd src/github.com/opentable/sous-demo && \
  go build . && \
  mkdir /built && \
  echo '\
    {"image": {"type": "Docker", "from": "scratch"}, \
     "files": [{"source": {"dir": "/built"}, "dest": {"dir": "/"}}], \
     "exec": ["/sous-demo"]}\
  ' > $SOUS_RUN_IMAGE_SPEC && \
  cp sous-demo /built
