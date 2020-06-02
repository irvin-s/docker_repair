FROM node:9.6-alpine  
LABEL maintainer="Josh Mostafa <jmostafa@cozero.com.au>"  
  
ENV COFFEELINT_VERSION=2.0.6  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/* \  
&& npm install -g coffeelint@${COFFEELINT_VERSION}  
  
WORKDIR /app  
VOLUME /app  
  
COPY coffeelint.sh /coffeelint.sh  
COPY coffeelint.json /coffeelint.json  
ENTRYPOINT ["/coffeelint.sh"]  

