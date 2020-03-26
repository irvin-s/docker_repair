FROM golang:1.11.1-alpine AS builder

WORKDIR /app

COPY ./ ./reception

RUN apk add --update bash make git gcc libc-dev
RUN cd ./reception && make build-reception

# ---

FROM alpine

COPY --from=builder /app/reception/dist/reception /

EXPOSE 8080
ENTRYPOINT ["/reception"]
