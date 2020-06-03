FROM php:latest

COPY ./tl.phar /tl

ENTRYPOINT ["/tl"]
