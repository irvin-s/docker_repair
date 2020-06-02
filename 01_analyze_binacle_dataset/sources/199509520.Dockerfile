# This file creates a container that runs a Caliopen lmtp server
# Important:
# Author: Caliopen
# Date: 2018-07-20

FROM public-registry.caliopen.org/caliopen_go as builder

ADD . /go/src/github.com/CaliOpen/Caliopen/src/backend
WORKDIR /go/src/github.com/CaliOpen/Caliopen/src/backend

# Fetch dependencies needed for Caliopen GO apps
RUN govendor sync -v

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' github.com/CaliOpen/Caliopen/src/backend/protocols/go.smtp/cmd/caliopen_lmtpd

FROM scratch
MAINTAINER Caliopen

# Add CA certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=builder /go/src/github.com/CaliOpen/Caliopen/src/backend/caliopen_lmtpd /usr/local/bin/caliopen_lmtpd

WORKDIR "/etc/caliopen"
ENTRYPOINT ["caliopen_lmtpd", "serve", "-c", "lmtp", "--configpath", "/etc/caliopen", "-p", "/caliopen_lmtpd.pid"]

EXPOSE 2525
