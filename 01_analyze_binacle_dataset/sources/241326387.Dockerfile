# CoreOS/Clair v2.0
# docker run --rm supinf/clair:2.0

FROM golang:1.12.3-alpine3.9 AS build
ENV CLAIR_VERSION=v2.0.8 \
    REPO=github.com/coreos/clair
RUN apk add --no-cache git
RUN go get "${REPO}"
WORKDIR /go/src/github.com/coreos/clair
RUN git checkout "${CLAIR_VERSION}"
RUN go build -ldflags "-s -w -X ${REPO}/pkg/version.Version=${CLAIR_VERSION}" "${REPO}/cmd/clair"

FROM alpine:3.9
COPY --from=build /go/src/github.com/coreos/clair/clair /clair
RUN apk add --no-cache git rpm xz
CMD ["/clair"]
