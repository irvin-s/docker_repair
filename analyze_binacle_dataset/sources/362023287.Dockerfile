FROM golang:1.7

# Add deploy key.
COPY ./key_sous@example.com /root/.ssh/id_rsa
# Add github.com to known hosts.
RUN ssh-keyscan github.com > /root/.ssh/known_hosts
RUN chmod -R og-rwx /root/.ssh

# Install sous using only vendored dependencies (no go get).
COPY vendor /go/src
COPY main.go /go/src/github.com/opentable/sous-server/
WORKDIR /go/src/github.com/opentable/sous-server
RUN go install -v
WORKDIR /go/src/github.com/opentable/sous
RUN go install -v

# Run sous server.
# NOTE: You must have set PORT0, GDM_REPO
CMD /go/bin/sous-server
