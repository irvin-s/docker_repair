FROM sneck/openrc

RUN apk add --no-cache nfs-utils \
    && rm -rf "/tmp/"* \
    \
    && rc-update add nfs \
    \
    && cp /etc/inittab /etc/inittab.bak \
    && cat /etc/inittab.bak | sed 's|::sysinit:/sbin/openrc sysinit|::sysinit:/entrypoint.sh\n&|' > /etc/inittab \
    && rm -rf /etc/inittab.bak

ADD docker-entrypoint.sh /entrypoint.sh

EXPOSE 2049 111/tcp 111/udp 20048

ENTRYPOINT ["/sbin/init"]