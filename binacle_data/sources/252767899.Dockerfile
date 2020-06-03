FROM mhart/alpine-node:6  
MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"  
# RUN apk update && apk add python  
RUN npm i -g azure-cli@0.10.0  
  
ENTRYPOINT ["/usr/bin/azure"]  

