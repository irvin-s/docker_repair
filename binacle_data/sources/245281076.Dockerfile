FROM alpine

#ca-certificates openssl

RUN echo "http://nl.alpinelinux.org/alpine/latest-stable/main" > /etc/apk/repositories \
&& echo "http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
&& echo "http://nl.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& echo "nameserver 8.8.8.8" >> /etc/resolv.conf && apk update \
&& apk add libstdc++ \
&& rm -rf /var/cache/apk/ && mkdir -p /var/cache/apk && rm -rf /tmp/*
