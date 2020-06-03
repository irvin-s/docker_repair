FROM golang:1.10-alpine as builder

# Get git
RUN apk add --no-cache curl git

# Get glide
RUN go get github.com/Masterminds/glide

# Where factom-walletd sources will live
WORKDIR $GOPATH/src/github.com/FactomProject/factom-walletd

# Get the dependencies
COPY glide.yaml glide.lock ./

# Install dependencies
RUN glide install -v


# Install dependencies
RUN glide install -v

# Populate the rest of the source
COPY . .

ARG GOOS=linux

# Build and install factom-walletd
RUN go install -ldflags "-X github.com/FactomProject/factom-walletd/vendor/github.com/FactomProject/factom/wallet.WalletVersion=`cat ./vendor/github.com/FactomProject/factom/wallet/VERSION`"

# Now squash everything
FROM alpine:3.6

# Get git
RUN apk add --no-cache ca-certificates curl git

RUN mkdir -p /go/bin
COPY --from=builder /go/bin/factom-walletd /go/bin/factom-walletd

ENTRYPOINT ["/go/bin/factom-walletd"]

EXPOSE 8089
