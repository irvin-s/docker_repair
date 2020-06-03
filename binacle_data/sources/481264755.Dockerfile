FROM python:2-alpine
RUN apk --update add "postgresql>9.6" --repository https://dl-cdn.alpinelinux.org/alpine/edge/main && pip install s3cmd && rm -rf /var/cache/apk/*
