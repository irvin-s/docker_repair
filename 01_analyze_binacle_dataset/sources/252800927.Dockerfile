FROM gliderlabs/alpine:3.3  
RUN apk-install ca-certificates \  
&& apk-install openssl  

