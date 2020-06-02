FROM alpine:3.6

RUN apk --update add bash && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENV FROM_FILE ""
ENV TO_FILE ""
ENV CHECK_INTERVAL 1

ENTRYPOINT ["/entrypoint.sh"]
