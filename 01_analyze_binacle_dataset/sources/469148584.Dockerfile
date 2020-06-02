FROM kylemanna/openvpn

RUN apk add --update dialog && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

RUN mkdir -p /setup/data

