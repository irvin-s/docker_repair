FROM alpine:3.5

RUN mkdir -p /opt/vsm/certs

ADD dist/vsmd_linux_amd64* /opt/vsm/vsmd
ADD config.yaml /opt/vsm/config.yaml
ADD certs /opt/vsm/certs

WORKDIR /opt/vsm
ENTRYPOINT ["./vsmd"]