FROM alpine:latest

RUN apk --update add nodejs npm \
    && rm -f /var/cache/apk/*

ENTRYPOINT ["node"]
CMD ["--version"]
