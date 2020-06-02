FROM golang:1.11-alpine AS builder
WORKDIR /go/src/whereabouts
COPY . .
RUN CGO_ENABLED=0 go build -o /whereabouts -ldflags="-s -w"

FROM alpine:3.8
RUN apk --no-cache add ca-certificates
COPY --from=builder /whereabouts /
RUN adduser -D app && chown app:app /whereabouts
USER app
CMD /whereabouts -host 0.0.0.0
