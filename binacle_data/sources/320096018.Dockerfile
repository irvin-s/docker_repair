FROM alpine:latest
# ssr config
ENV PORT 8989
ENV PASSWD 123456780
ENV METHOD none
ENV PROTOCOL auth_chain_a
ENV OBFS tls1.2_ticket_auth
ENV DNS_ADDR 8.8.8.8
ENV DNS_ADDR_2 8.8.4.4
# kcptun config
ENV VERSION 20180316
ENV MODE server
ENV listen_port 4000
ENV remote_server 127.0.0.1
ENV remote_port 8989

RUN apk --no-cache add git python libsodium wget tar && \
    git clone -b manyuser https://github.com/shadowsocksr-rm/shadowsocksr.git && \
    wget https://github.com/xtaci/kcptun/releases/download/v${VERSION}/kcptun-linux-amd64-${VERSION}.tar.gz -O kcptun.tar.gz && \
    tar -xzvf kcptun.tar.gz && rm kcptun.tar.gz && \    
    apk del --purge git wget tar

COPY entrypoint.sh /entrypoint.sh
RUN mkdir kcptun && mv *_linux_amd64 /kcptun
ADD *-config.json /kcptun/

EXPOSE $PORT $listen_port
CMD /entrypoint.sh
