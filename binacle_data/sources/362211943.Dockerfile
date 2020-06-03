FROM alpine:3.2

RUN apk update && \
    apk add socat && \
    rm -r /var/cache/apk/*

COPY start.sh /start.sh

# Not really necessary for our purposes
EXPOSE 5522

ENTRYPOINT ["/start.sh"]
