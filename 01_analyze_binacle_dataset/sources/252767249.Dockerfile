FROM alpine:3.6  
RUN apk update && \  
apk add --no-cache \  
curl \  
wget \  
openssl \  
ca-certificates \  
iproute2  
  
ENTRYPOINT ["curl"]  

