FROM golang:1.11.5
MAINTAINER github.com/cloudpatron/cloudpatron

RUN apt-get update \
    && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /go/src/github.com/cloudpatron/cloudpatron

RUN go get -v \
    github.com/jteeuwen/go-bindata/... \
    github.com/dustin/go-humanize \
    github.com/julienschmidt/httprouter \
    github.com/Sirupsen/logrus \
    github.com/gorilla/securecookie \
    golang.org/x/crypto/acme/autocert \
    golang.org/x/time/rate \
	golang.org/x/crypto/bcrypt \
    go.uber.org/zap \
	gopkg.in/gomail.v2 \
    github.com/armon/circbuf \
    github.com/microcosm-cc/bluemonday \
    gopkg.in/russross/blackfriday.v2 \
    github.com/stripe/stripe-go

COPY *.go ./
COPY static ./static
COPY templates ./templates
COPY email ./email

ARG BUILD_VERSION=unknown

ENV GODEBUG="netdns=go http2server=0"
ENV GOPATH="/go"

RUN go-bindata --pkg main static/... templates/... email/... \
    && go fmt \
    && go vet --all

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -v --compiler gc --ldflags "-extldflags -static -s -w -X main.version=${BUILD_VERSION}" -o /usr/bin/cloudpatron-linux-amd64
