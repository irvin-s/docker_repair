# This file creates a container that runs a Caliopen identity poller
# Important:
# Author: Caliopen
# Date: 2018-07-20

FROM public-registry.caliopen.org/caliopen_go as builder

ADD . /go/src/github.com/CaliOpen/Caliopen/src/backend
WORKDIR /go/src/github.com/CaliOpen/Caliopen/src/backend

# Fetch dependencies needed for Caliopen GO apps
RUN govendor sync -v

RUN CGO_ENABLED=0 GOOS=linux go install -a -ldflags '-extldflags "-static"' github.com/CaliOpen/Caliopen/src/backend/workers/go.remoteIDs/cmd/idpoller

FROM scratch
MAINTAINER Caliopen

# Add CA certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=builder /go/bin/idpoller /usr/local/bin/idpoller

WORKDIR "/etc/caliopen"
ENTRYPOINT [ "idpoller", "start", "-c", "idpoller", "--configpath", "/etc/caliopen", "-p", "/idpoller.pid"]
