FROM alpine:latest
RUN apk --update add postgresql && rm -rf /var/cache/apk/*
