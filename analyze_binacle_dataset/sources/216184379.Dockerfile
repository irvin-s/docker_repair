FROM alpine:latest

RUN apk --update add ca-certificates && rm -rf /var/cache/apk/*

ADD dist/ncd_linux_386 /usr/local/bin/harbor-compose
RUN chmod +x /usr/local/bin/harbor-compose

WORKDIR /work

ENTRYPOINT ["harbor-compose"]
CMD ["--help"]