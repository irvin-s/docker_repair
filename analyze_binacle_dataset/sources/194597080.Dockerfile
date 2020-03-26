## Version: 0.3
FROM alpine
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Install packages
RUN apk update && \
    apk add dnsmasq

## Start service
CMD ["dnsmasq", "--keep-in-foreground"]

### allow ports
EXPOSE 53

