FROM golang:1.9 AS build

ARG ARCH=amd64
ARG GOOS=linux

# Copy and build dns2peerlist
COPY dns2peerlist /go/src/dns2peerlist
WORKDIR /go/src/dns2peerlist/cmd
RUN GOARCH=$ARCH GOOS=$GOOS CGO_ENABLED=0 go build -o dns2peerlist

# Download and build gohttpserver
RUN go get github.com/codeskyblue/gohttpserver
WORKDIR /go/src/github.com/codeskyblue/gohttpserver
RUN CGO_ENABLED=0 GOOS=$GOOS GOARCH=$GOARCH go build -a -installsuffix cgo -o gohttpserver .

FROM skycoin:new

RUN mkdir -p /app/public
WORKDIR /app

COPY --from=build /go/src/dns2peerlist/cmd/dns2peerlist /usr/local/bin/dns2peerlist
COPY --from=build /go/src/github.com/codeskyblue/gohttpserver/gohttpserver /app/gohttpserver
COPY --from=build /go/src/github.com/codeskyblue/gohttpserver/res /app/res
COPY ./launcher.sh /usr/local/bin/launcher.sh

RUN chmod +x /usr/local/bin/launcher.sh

# Replace the CMD by a custom script that first launch
ENTRYPOINT ["launcher.sh", "--web-interface-addr=0.0.0.0", "--gui-dir=/usr/local/skycoin/src/gui/static"]
