FROM golang:1.11-alpine3.7 as builder
RUN apk add --no-cache ca-certificates git && \
    apk add --no-cache bash git openssh gcc musl-dev

WORKDIR /go/src/

ENV GO111MODULE on
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN go build -gcflags='-N -l' -o /goservice .

FROM alpine as release
RUN apk add --no-cache ca-certificates curl

COPY --from=builder /goservice /goservice
EXPOSE 10201 10202 10203
ENTRYPOINT ["/goservice"]
