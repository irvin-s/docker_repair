FROM golang:1.11-alpine

WORKDIR /app

RUN apk add --no-cache git build-base

COPY proxy .

RUN go build

###

FROM golang:1.11-alpine

WORKDIR /app

COPY --from=0 /app/proxy /app/proxy
CMD /app/proxy

