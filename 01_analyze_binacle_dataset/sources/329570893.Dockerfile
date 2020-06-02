FROM golang:1.9 as builder
COPY ./ ./
RUN make build
RUN pwd && ls -lah

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/pgme /
COPY --from=builder /go/template /template
CMD ["/pgme"]