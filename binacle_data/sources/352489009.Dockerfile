FROM golang:1.9.2

RUN go get github.com/influxdata/inch
WORKDIR /go/src/github.com/influxdata/inch/cmd/inch
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -i .

FROM alpine
RUN apk add --no-cache --update ca-certificates
COPY --from=0 /go/src/github.com/influxdata/inch/cmd/inch/inch /usr/bin/inch
ENTRYPOINT /usr/bin/inch
