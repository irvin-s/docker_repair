FROM alpine:latest

RUN apk --update add python3 \
    && rm -f /var/cache/apk/*

ENTRYPOINT ["python3"]
CMD ["--version"]
