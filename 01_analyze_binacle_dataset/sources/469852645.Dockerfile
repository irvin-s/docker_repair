FROM golang:1.9.6-alpine3.6

COPY eventer /
#COPY ca-certificates.crt /etc/ssl/certs/

#   nobody:nobody
USER 65534:65534
ENTRYPOINT ["/eventer"]
