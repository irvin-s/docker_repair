FROM alpine:3.3

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --update nikto@testing perl-net-ssleay && rm -fr /var/cache/apk/*

ENTRYPOINT ["/usr/bin/nikto.pl"]

CMD ["-h"]

