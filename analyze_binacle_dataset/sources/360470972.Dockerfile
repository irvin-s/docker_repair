FROM golang
MAINTAINER Ferran Rodenas <frodenas@gmail.com>

# Set environment variables
ENV CGO_ENABLED 0
ENV GOARCH      amd64
ENV GOARM       5
ENV GOOS        linux

# Build BOSH Registry
RUN go get -a -installsuffix cgo -ldflags '-s' github.com/cloudfoundry-community/pe-rds-broker

# Add files
ADD Dockerfile.final /go/bin/Dockerfile
ADD config-sample.json /go/bin/config.json

# Command to run
CMD docker build -t cfplatformeng/rds-broker /go/bin
