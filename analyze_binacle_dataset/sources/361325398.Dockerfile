FROM alpine:edge
RUN apk add --update netcat-openbsd && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nc"]
