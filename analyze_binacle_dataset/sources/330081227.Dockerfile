FROM golang:1.9 as binary
MAINTAINER kmtruckenmiller@gmail.com
WORKDIR /go/src/github.com/ktruckenmiller/spot-checker
COPY . .
RUN go get -v
ARG GOOS
ARG GOARCH
ENV CGO_ENABLED=0
RUN go build -o spot_term_watcher .

FROM alpine:3.6 as alpine
RUN apk add -U --no-cache ca-certificates

FROM scratch
WORKDIR /
COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=binary /go/src/github.com/ktruckenmiller/spot-checker/spot_term_watcher /bin/
ENTRYPOINT ["/bin/spot_term_watcher"]
