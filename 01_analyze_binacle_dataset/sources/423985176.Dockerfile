FROM golang:alpine as builder

WORKDIR /go/src/handler

COPY . .

# Run a gofmt and exclude all vendored code.
RUN test -z "$(gofmt -l $(find . -type f -name '*.go' -not -path "./vendor/*" -not -path "./function/vendor/*"))" || { echo "Run \"gofmt -s -w\" on your Golang code"; exit 1; }; \
    go test $(go list ./... | grep -v /vendor/) -cover; \
    CGO_ENABLED=0 GOOS=linux go build --ldflags "-s -w" -a -installsuffix cgo -o main .


FROM scratch

WORKDIR /home/app/

COPY --from=builder /go/src/handler/main .

USER 1000:1000
