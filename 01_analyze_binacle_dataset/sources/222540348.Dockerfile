FROM alpine:3.3

MAINTAINER tomwillfixit 

RUN apk update && apk add curl && rm -rf /var/cache/apk/*

COPY helloworld.bin / 

EXPOSE 80

HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
      CMD curl -f http://localhost:80 || exit 1

ENTRYPOINT ["/helloworld.bin"]

