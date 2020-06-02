FROM node:9-alpine as angular-cli  
  
LABEL authors="Sebastian Wegert"  
#Linux setup  
RUN apk update \  
&& apk add --update alpine-sdk \  
&& apk del alpine-sdk \  
&& rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \  
&& npm cache verify \  
&& sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd  
  
#Angular CLI  
RUN npm install -g @angular/cli@1.7.4  

