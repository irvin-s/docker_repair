FROM golang:1.8

LABEL maintainer="Stephen Afam-Osemene <stephenafamo@gmail.com>"

EXPOSE 80 443

COPY .env /.env
COPY init.sh /init.sh

CMD ["/init.sh"]
