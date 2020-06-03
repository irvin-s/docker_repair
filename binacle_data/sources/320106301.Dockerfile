# Credits: https://github.com/kylemanna/docker-openvpn

FROM kafebob/rpi-alpine:3.6

LABEL maintainer="Luis Toubes <luis@toub.es>"

ADD https://github.com/kylemanna/docker-openvpn/archive/master.zip /tmp

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --update openvpn iptables bash easy-rsa openvpn-auth-pam google-authenticator pamtester unzip && \
    unzip /tmp/master.zip -d /tmp && \
    cp /tmp/docker-openvpn-master/bin/* /usr/local/bin && \
    cp /tmp/docker-openvpn-master/otp/openvpn /etc/pam.d/ && \
    chmod a+x /usr/local/bin/* && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    apk del unzip && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

# Prevents refused client connection because of an expired CRL
ENV EASYRSA_CRL_DAYS 3650

VOLUME ["/etc/openvpn"]

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

CMD ["ovpn_run"]
