FROM alpine

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update add aircrack-ng@testing && rm -rf /var/cache/apk/*
