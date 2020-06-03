FROM scaleway/alpine:3.2
RUN apk add --update curl && rm -rf /var/cache/apk/*
ENTRYPOINT ["curl"]