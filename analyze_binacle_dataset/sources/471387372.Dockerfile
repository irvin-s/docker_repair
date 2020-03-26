FROM alpine:3.7
RUN apk --no-cache add ca-certificates
COPY bin/provisioner /usr/local/bin/provisioner
ENTRYPOINT ["/usr/local/bin/provisioner"]
