FROM alpine:latest as certs

RUN apk --update add ca-certificates

FROM scratch

ARG PLATFORM=linux-amd64
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY manifest-tool-${PLATFORM} /manifest-tool

ENTRYPOINT [ "/manifest-tool" ]
