FROM golang:1.8-alpine
ADD . /go/src/hello-app-cdn
RUN go install hello-app-cdn

FROM alpine:latest
COPY --from=0 /go/bin/hello-app-cdn .
ENV PORT 8080
CMD ["./hello-app-cdn"]
