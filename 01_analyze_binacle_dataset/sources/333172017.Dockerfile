FROM golang:1.9 as builder
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.3.2/dep-linux-amd64 && chmod +x /usr/local/bin/dep
WORKDIR /go/src/github.com/itamaro/gcp-go-night-king/
# Use dep to manage the dependencies without the source code (before copying it)
# https://github.com/golang/dep/blob/master/docs/FAQ.md#how-do-i-use-dep-with-docker
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure -vendor-only
COPY main.go nightking.go ./
# Need to create 100% static binaries to make it work in scratch / alpine
# https://github.com/golang/go/issues/9344#issuecomment-69944514
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o nightking .

# The app image - using "alpine" over "scratch" since it needs ca-certificates,
# and the overhead is small enough (~5MB) to keep it simple vs. adding (and
# managing) the certificates as part of the codebase.
FROM alpine:3.7
# if the runtime doesn't have CA certificates, the pubsub client creation hangs
# indefinitely - https://github.com/grpc/grpc-go/issues/1768
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/itamaro/gcp-go-night-king/nightking /usr/bin/
ENTRYPOINT ["nightking"]
