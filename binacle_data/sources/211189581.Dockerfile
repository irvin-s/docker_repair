FROM alpine

RUN apk add --no-cache figlet

USER 65000:65000

ENTRYPOINT ["figlet"]
