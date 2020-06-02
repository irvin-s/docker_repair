FROM alpine  
  
RUN apk add --update \  
bash \  
curl \  
git \  
jq \  
&& rm -rf /var/cache/apk/*  
  
VOLUME /data  

