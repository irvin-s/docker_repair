# Multi-stage build step 0
FROM golang:1.8

RUN mkdir -p /go/src/app
WORKDIR /go/src/app
COPY . /go/src/app

ENV CGO_ENABLED=0

RUN go-wrapper download
RUN go-wrapper install

# Multi-stage build step 1
FROM scratch
COPY --from=0 /go/bin/app /
COPY --from=0 /go/src/app/templates /templates

CMD ["/app"] 
