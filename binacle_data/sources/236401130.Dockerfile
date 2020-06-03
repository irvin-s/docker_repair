FROM alpine:3.5

RUN \
        set -ex \
    && \
        apk add --no-cache --virtual .build-deps \
            bash \
            cmake \
            build-base \
            gcc \
            abuild \
            binutils \
            make \
            linux-headers \
            libc-dev \
            curl-dev
