#  
# Dockerfile for ShadowsocksR  
#  
FROM alpine:3.4  
EXPOSE 80 443 8991  
ENV SSR_URL https://github.com/ToyoDAdoubi/shadowsocksr/archive/manyuser.zip  
  
RUN set -ex \  
&& apk --update add \--no-cache libsodium py-pip \  
&& pip --no-cache-dir install $SSR_URL \  
&& rm -rf /var/cache/apk  
  
ENV SERVER_ADDR 0.0.0.0  
ENV SERVER_PORT 8991  
ENV PASSWORD p@ssw0rd  
ENV METHOD aes-256-cfb  
ENV PROTOCOL auth_aes128_md5  
ENV OBFS tls1.2_ticket_auth  
ENV TIMEOUT 300  
EXPOSE $SERVER_PORT/tcp  
EXPOSE $SERVER_PORT/udp  
  
WORKDIR /usr/bin/  
  
CMD ssserver -s $SERVER_ADDR \  
-p $SERVER_PORT \   
-k $PASSWORD \   
-m $METHOD \   
-O $PROTOCOL \   
-o $OBFS \   
-t $TIMEOUT

