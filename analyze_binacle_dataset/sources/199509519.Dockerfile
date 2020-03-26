# This file creates a container that runs a Caliopen API (GO based)
# Important:
# Author: Caliopen
# Date: 2018-07-20

FROM public-registry.caliopen.org/caliopen_go as builder

ADD . /go/src/github.com/CaliOpen/Caliopen/src/backend
WORKDIR /go/src/github.com/CaliOpen/Caliopen/src/backend

# Fetch dependencies needed for Caliopen GO apps
RUN govendor sync -v

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' github.com/CaliOpen/Caliopen/src/backend/interfaces/REST/go.server/cmd/caliopen_rest

FROM scratch
MAINTAINER Caliopen

# Add CA certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Add email templates
COPY --from=builder /go/src/github.com/CaliOpen/Caliopen/src/backend/defs/notifiers/templates /etc/defs/notifiers/templates

COPY --from=builder /go/src/github.com/CaliOpen/Caliopen/src/backend/caliopen_rest /usr/local/bin/caliopen_rest

WORKDIR  "/etc/caliopen"
ENTRYPOINT ["caliopen_rest", "serve", "-c" ,"apiv2", "--configpath" ,"/etc/caliopen", "-p", "/caliopen_rest.pid"]

EXPOSE 6544
