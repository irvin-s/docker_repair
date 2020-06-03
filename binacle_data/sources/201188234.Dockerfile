FROM golang:1.9-alpine
RUN apk add --no-cache git make gcc musl-dev linux-headers bash
