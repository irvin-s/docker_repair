FROM golang:1.11.1-alpine AS builder

WORKDIR /app

COPY ./ ./barista

RUN apk add --update bash make git gcc libc-dev
RUN cd ./barista && make build-barista

# ---

FROM alpine

COPY --from=builder /app/barista/dist/barista /

EXPOSE 8080
ENTRYPOINT ["/barista"]
