FROM node:9.6-alpine  
LABEL maintainer="J Nagel <jnagel@cozero.com.au>"  
  
WORKDIR /app  
COPY . /app  
  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/*  
  
# Move linter files to /linter dir so that they won't get overwritten  
# when files get mounted into /app  
RUN mkdir /linter && mv htmlhint.sh /linter/htmlhint.sh && \  
npm install && mv node_modules /linter  
  
ENTRYPOINT ["/linter/htmlhint.sh"]  

