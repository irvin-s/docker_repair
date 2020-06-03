FROM alpine:latest

ENV PORT 8989
ENV PASSWD 123456780
ENV METHOD none
ENV PROTOCOL auth_chain_a
ENV OBFS tls1.2_ticket_auth
ENV DNS_ADDR 8.8.8.8
ENV DNS_ADDR_2 8.8.4.4

RUN apk --no-cache add git python libsodium && \
    git clone -b manyuser https://github.com/shadowsocksr-rm/shadowsocksr.git && \
    apk del --purge git
WORKDIR shadowsocksr/shadowsocks
EXPOSE $PORT
CMD python server.py -p $PORT -k $PASSWD -m $METHOD -O $PROTOCOL -o $OBFS start
