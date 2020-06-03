FROM alpine:3.7
COPY bin/driver deployer /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/deployer"]
