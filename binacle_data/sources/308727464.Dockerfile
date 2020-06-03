FROM golang:1.10
WORKDIR /go/src/github.com/heptiolabs/cruise

RUN go get github.com/golang/dep/cmd/dep
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure -v -vendor-only

COPY cmd cmd
COPY internal internal
RUN CGO_ENABLED=0 GOOS=linux go install -ldflags="-w -s" -v github.com/heptiolabs/cruise/cmd/cruise

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
COPY --from=0 /go/bin/cruise /bin/cruise
