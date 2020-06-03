FROM alpine:3.4
ENV TZ=Asia/Shanghai
RUN apk update \
    && apk --no-cache add dnsmasq
EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k"]
