# Build
FROM golang:alpine AS build

ARG TAG
ARG BUILD

ENV LIBRARY msgbus
ENV SERVER msgbusd
ENV CLIENT msgbus
ENV REPO prologic/$LIBRARY

RUN apk add --update git make build-base && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/$REPO
COPY . /go/src/github.com/$REPO
RUN make TAG=$TAG BUILD=$BUILD build

# Runtime
FROM scratch

ENV LIBRARY msgbus
ENV SERVER msgbusd
ENV CLIENT msgbus
ENV REPO prologic/$LIBRARY

LABEL msgbud.app main

COPY --from=build /go/src/github.com/${REPO}/cmd/${SERVER}/${SERVER} /${SERVER}
COPY --from=build /go/src/github.com/${REPO}/cmd/${CLIENT}/${CLIENT} /${CLIENT}

EXPOSE 8000/tcp

ENTRYPOINT ["/msgbusd"]
CMD []
