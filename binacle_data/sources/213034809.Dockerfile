FROM alpine:edge
MAINTAINER Mathias Klippinge <mathias.klippinge@gmail.com> (@klippx)

RUN apk add -U openssl

ENV CERTIFICATE example.crt

CMD ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
