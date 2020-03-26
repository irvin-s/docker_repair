FROM alpine:3.6

RUN apk add --update --no-cache ruby asciidoctor && \
    gem install --no-ri --no-rdoc coderay && \
    gem cleanup && \
    rm -rf /tmp/* /var/cache/apk/*

WORKDIR /documents
VOLUME /documents

CMD ["/bin/sh"]
