FROM golang:1.10-alpine AS builder

RUN apk add --no-cache make

COPY .  /go/src/github.com/blippar/git2etcd
WORKDIR /go/src/github.com/blippar/git2etcd

RUN cd /go/src/github.com/blippar/git2etcd \
 && go build -v

FROM alpine:3.7 AS runtime

# Install tini to /usr/local/sbin
ADD https://github.com/krallin/tini/releases/download/v0.17.0/tini-muslc-amd64 /usr/local/sbin/tini

# Install runtime dependencies & create runtime user
RUN apk --no-cache --no-progress add ca-certificates git libssh2 openssl \
 && chmod +x /usr/local/sbin/tini && mkdir -p /opt \
 && adduser -D g2e -h /opt/git2etcd -s /bin/sh \
 && su g2e -c 'cd /opt/git2etcd; mkdir -p bin config data'

# Switch to user context
USER g2e
WORKDIR /opt/git2etcd

# Copy git2etcd binary to /opt/git2etcd/bin
COPY --from=builder /go/src/github.com/blippar/git2etcd/git2etcd /opt/git2etcd/bin/git2etcd
COPY config.example.json /opt/git2etcd/config/config.json
ENV PATH $PATH:/opt/git2etcd/bin

# Container configuration
EXPOSE 4242
VOLUME ["/opt/git2etcd/data"]
ENTRYPOINT ["tini", "-g", "--"]
CMD ["/opt/git2etcd/bin/git2etcd", "-conf_dir=/opt/git2etcd/config"]
