# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

ENV REPO  github.com/himanshub16/outbound-go

# Copy the local package files to the container's workspace.
ADD . /go/src/${REPO}

# Get dependencies
RUN go get ${REPO}


WORKDIR /go/src/${REPO}

RUN go build -ldflags="-s -w" -o outbound-go

# Run the service
ENTRYPOINT ["outbound-go"]

# Document that the service listens on port 9000.
EXPOSE 9000
