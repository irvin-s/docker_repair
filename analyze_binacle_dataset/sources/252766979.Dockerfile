FROM alpine:latest  
MAINTAINER Andrew Chandler <andrew+dockerhub@phoe.be>  
RUN apk add --update --no-cache nodejs nodejs-npm \  
&& npm install -g cowsay \  
&& npm cache clean --force  
ADD lunchme.sh /lunchme.sh  
entrypoint /lunchme.sh  

