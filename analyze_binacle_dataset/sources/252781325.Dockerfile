FROM node:9.6-alpine  
LABEL maintainer="Josh Mostafa <jmostafa@cozero.com.au>"  
  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/*  
  
WORKDIR /app  
  
COPY . /app  
  
# Move linter files to /linter dir so that they won't get overwritten  
# when files get mounted into /app  
RUN mkdir /linter && mv markdownlint.sh /linter/markdownlint.sh && \  
mv .markdownlint.json /linter/.markdownlint.json && \  
npm install && mv node_modules /linter  
  
ENTRYPOINT ["/linter/markdownlint.sh"]  

