FROM alpine

ENV TZ=Asia/Shanghai

RUN apk --no-cache --no-progress upgrade && \
  apk --no-cache --no-progress add perl curl bash iptables pcre openssl dnsmasq ipset iproute2 tzdata jq && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY init.sh update.sh check.sh /
COPY ss-tproxy.conf v2ray.conf gfwlist.ext /sample_config/

RUN chmod +x /init.sh /update.sh /check.sh && /update.sh

HEALTHCHECK --interval=600s --timeout=60s \
            CMD /check.sh

CMD ["/init.sh","daemon"]