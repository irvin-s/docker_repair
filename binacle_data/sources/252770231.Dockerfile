FROM alpine:3.5  
RUN apk add --no-cache \  
g++ \  
libstdc++ \  
&& apk del --purge \  
g++  
ADD zerotier-member /zerotier-member  
ENTRYPOINT ["/zerotier-member"]  

