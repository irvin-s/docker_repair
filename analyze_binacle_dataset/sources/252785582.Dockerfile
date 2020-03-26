FROM alpine:edge  
  
COPY resource/* /opt/resource/  
  
RUN apk add --no-cache \  
ca-certificates \  
curl \  
jq \  
openssh \  
openssl \  
&& update-ca-certificates

