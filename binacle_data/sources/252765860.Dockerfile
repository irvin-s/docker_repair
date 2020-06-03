FROM node:alpine  
  
RUN apk --update add bash wget dpkg-dev \  
&& mkdir -p /home/mjml \  
&& npm init -y \  
&& npm install -g mjml  
  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
WORKDIR /home/mjml  
  
ENTRYPOINT ["/entrypoint.sh"]

