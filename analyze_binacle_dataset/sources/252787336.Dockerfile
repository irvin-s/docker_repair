#  
# Dockerfile for ShadowsocksR  
#  
FROM alpine:3.4  
ENV SSR_URL https://github.com/teddysun/shadowsocksr/archive/manyuser.zip  
  
RUN set -ex \  
&& apk --update add --no-cache libsodium py-pip \  
&& pip --no-cache-dir install $SSR_URL \  
&& rm -rf /var/cache/apk  
  
ENTRYPOINT ["/usr/bin/ssserver"]  

