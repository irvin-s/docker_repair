FROM golang:1.7.1-alpine
LABEL maintainer="Kazumichi Yamamoto <yamamoto.febc@gmail.com>"

RUN set -x && apk add --no-cache --virtual .build_deps bash git make zip 
RUN go get -u github.com/kardianos/govendor

ADD . /go/src/github.com/sacloud/sackerel
WORKDIR /go/src/github.com/sacloud/sackerel
RUN make build

ENTRYPOINT ["bin/sackerel"]
