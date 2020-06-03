
#build stage
FROM golang:1.9-alpine AS builder
WORKDIR /go/src/app
COPY . .
RUN go build -o salienbot .

#final stage
FROM alpine:latest
LABEL Name=salienbot-go
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/src/app/salienbot /app/salienbot
ENTRYPOINT ["/app/salienbot"]
