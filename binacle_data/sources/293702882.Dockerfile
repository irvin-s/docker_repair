#
# Builder
#
FROM abiosoft/caddy:builder as builder

ARG RELEASE
ARG PKG
ARG COMMIT

COPY . /usr/src/caddy-ingress-controller

RUN mkdir -p ${GOPATH}/src/k8s.io
RUN git clone https://github.com/arctype-co/ingress.git ${GOPATH}/src/k8s.io/ingress
RUN git clone https://github.com/arctype-co/caddy.git ${GOPATH}/src/github.com/mholt/caddy
RUN mv /usr/src/caddy-ingress-controller ${GOPATH}/src/${PKG}
WORKDIR $GOPATH/src/${PKG}
RUN go get -v ./...
RUN go build -a -installsuffix cgo \
		-ldflags "-s -w -X ${PKG}/pkg/version.RELEASE=${RELEASE} -X ${PKG}/pkg/version.COMMIT=${COMMIT} -X ${PKG}/pkg/version.REPO=${REPO_INFO}" \
		-o /caddy-ingress-controller ${PKG}/pkg/cmd/controller

# Credits to https://github.com/abiosoft/caddy-docker
FROM alpine:3.9
MAINTAINER Kevin Minehart <kminehart@wehco.com>

ARG plugins=http.jwt,http.proxyprotocol,http.realip

RUN apk add --no-cache openssh-client git tar curl

COPY --from=builder /caddy-ingress-controller /caddy-ingress-controller

EXPOSE 80 443 12015

# This is where TLS certificates from acme live.
VOLUME /root/.caddy

# This will copy the generated config files to the filesystem.
COPY ./etc /etc

CMD ["/caddy-ingress-controller"]
