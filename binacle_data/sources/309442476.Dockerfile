FROM wificoin-run:latest
MAINTAINER rench <185656156@qq.com>
ENV LANG en_US.UTF-8
COPY wificoin/wificoind /usr/bin/wificoind
COPY wificoin/wificoin-cli /usr/bin/wificoin-cli
COPY wificoin/wificoin-tx /usr/bin/wificoin-tx
RUN echo "wificoind --daemon && sleep 3 && ps -ef|grep wificoind|awk '{print \$2}' |xargs kill" > /usr/bin/init-wificoin.sh && \
    chmod +x /usr/bin/init-wificoin.sh
CMD ["wificoind"]
