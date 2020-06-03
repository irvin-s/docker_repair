
FROM golang:1.10

# Get git
RUN apt-get update \
    && apt-get -y install curl git \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get glide
RUN go get github.com/Masterminds/glide

# Where factom-cli sources will live
WORKDIR $GOPATH/src/github.com/FactomProject/factom-cli

# Get the dependencies
COPY glide.yaml glide.lock ./

# Install dependencies
RUN glide install -v

# Get goveralls for testing/coverage
RUN go get github.com/mattn/goveralls

# Populate the rest of the source
COPY . .

ARG GOOS=linux

# Build and install factom-cli
RUN go install

ENTRYPOINT ["/go/bin/factom-cli"]
