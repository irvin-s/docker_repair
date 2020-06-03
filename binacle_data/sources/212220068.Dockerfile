FROM golang:1.10

# Get git
RUN apt-get update \
    && apt-get -y install apt-utils curl git \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get glide
RUN go get github.com/Masterminds/glide

# Where factom-walletd sources will live
WORKDIR $GOPATH/src/github.com/FactomProject/factom-walletd

# Get the dependencies
COPY glide.yaml glide.lock ./

# Install dependencies
RUN glide install -v

# Get goveralls for testing/coverage
RUN go get github.com/mattn/goveralls

# Populate the rest of the source
COPY . .

# Install dependencies
RUN glide install -v

ARG GOOS=linux

# Build and install factom-walletd
RUN go install -ldflags "-X github.com/FactomProject/factom-walletd/vendor/github.com/FactomProject/factom/wallet.WalletVersion=`cat ./vendor/github.com/FactomProject/factom/wallet/VERSION`"

ENTRYPOINT ["/go/bin/factom-walletd"]

EXPOSE 8089
