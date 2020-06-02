FROM alpine

ENTRYPOINT ["openvpn"]
VOLUME ["/vpn"]

RUN apk add --no-cache openvpn
