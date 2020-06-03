FROM celeron1ghz/node-alpine  
  
WORKDIR /root/  
USER root  
ADD xvfb-run /usr/bin  
  
RUN apk --update --no-cache add xvfb \  
&& chmod +x /usr/bin/xvfb-run \  
&& npm install nightmare electron aws-sdk vo \  
&& ls -laR node_modules/ \  
&& node -v  

