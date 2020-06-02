FROM golang:1.12 as builder
 
RUN useradd -u 10001 updatey
  
WORKDIR /go/src/github.com/jw-s/updatey
 
RUN apt-get update && \
    apt-get install ca-certificates
 
COPY . .
 
RUN make build
 
FROM scratch
 
WORKDIR /
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/src/github.com/jw-s/updatey/bin/updatey /updatey
USER updatey
EXPOSE 8080
ENTRYPOINT ["/updatey"]