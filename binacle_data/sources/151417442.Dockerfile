FROM alpine:3.9.4
RUN apk add --no-cache openvpn
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["openvpn", "--config", "/etc/openvpn/openvpn.conf"]
