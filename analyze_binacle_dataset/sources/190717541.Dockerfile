FROM alpine

RUN apk --update --no-cache add openssl ca-certificates

ADD entrypoint.sh /entrypoint.sh

ADD openssl.cnf /etc/ssl/openssl.cnf

VOLUME [ "/certificates" ]

CMD [ "/entrypoint.sh" ]
