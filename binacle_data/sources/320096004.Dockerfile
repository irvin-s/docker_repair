FROM alpine:latest
MAINTAINER Winstonpro "https://github.com/WinstonH"
ENV TZ 'Asia/Shanghai'
RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*
RUN apk --no-cache add dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf
COPY resolv.dnsmasq /etc/resolv.dnsmasq
COPY sniproxy.conf /etc/dnsmasq.d/sniproxy.conf

EXPOSE 53/udp
ENTRYPOINT ["/usr/sbin/dnsmasq", "--keep-in-foreground"]
