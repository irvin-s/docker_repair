FROM alpine:latest

RUN set -ex \
    && apk add --update --no-cache ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk \
    && apk add --no-cache glibc-2.25-r0.apk glibc-bin-2.25-r0.apk \
    && rm glibc-2.25-r0.apk glibc-bin-2.25-r0.apk \
    && ln -s /lib/ld-musl-x86_64.so.1 /lib/libc.so

COPY sfhr /

CMD ["/sfhr", "--host", "0.0.0.0", "--mqttbroker", "mqtt", "1883"]
