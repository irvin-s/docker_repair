FROM golang:1.7

# Install vendored dumb-init.
COPY bin/dumb-init /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

# Install sous using only vendored dependencies (no go get).
RUN mkdir -p /go/src/github.com/opentable/sous
WORKDIR /go/src/github.com/opentable/sous
COPY . /go/src/github.com/opentable/sous
RUN go install -v

# Run sous server.
CMD /go/bin/sous server -listen ":$PORT0" -gdm-repo "$GDM_REPO"

