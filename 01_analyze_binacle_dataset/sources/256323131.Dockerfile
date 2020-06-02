# Build
FROM golang:alpine AS build

ARG TAG
ARG BUILD

ENV APP gopherclient
ENV REPO prologic/$APP

RUN apk add -U git make build-base && \
    apk add -U webkit2gtk-dev && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/$REPO
COPY . /go/src/github.com/$REPO
RUN make TAG=$TAG BUILD=$BUILD build

# Runtime
FROM scratch

ENV APP gopherclient
ENV REPO prologic/$APP

LABEL gopherclient.app main

COPY --from=build /go/src/github.com/${REPO}/${APP} /${APP}

EXPOSE 8080/tcp

ENTRYPOINT ["/gopherclient"]
CMD []
