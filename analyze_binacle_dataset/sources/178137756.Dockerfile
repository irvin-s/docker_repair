FROM golang:1.10-alpine as builder

# Get git
RUN apk add --no-cache curl git

# Get glide
RUN go get github.com/Masterminds/glide

# Where factom-cli sources will live
WORKDIR $GOPATH/src/github.com/FactomProject/factom-cli

# Get the dependencies
COPY glide.yaml glide.lock ./

# Install dependencies
RUN glide install -v

# Populate the rest of the source
COPY . .

ARG GOOS=linux

# Build and install factom-cli
RUN go install

# Now squash everything
FROM alpine:3.6

# Get git
RUN apk add --no-cache ca-certificates curl git

RUN mkdir -p /go/bin

COPY --from=builder /go/bin/factom-cli /go/bin/factom-cli


ENTRYPOINT ["/go/bin/factom-cli"]
