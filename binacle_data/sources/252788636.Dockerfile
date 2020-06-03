FROM node:0.10  
MAINTAINER Chris Smith <chris87@gmail.com>  
  
RUN npm install -g --unsafe-perm \  
coffee-script@1.7.1 \  
tapchat@0.0.42  
  
RUN \  
apt-get update && \  
apt-get -y install \  
expect  
  
ADD tapchat.expect tapchat.sh /  
  
EXPOSE 8067  
VOLUME /.tapchat  
  
CMD ["sh", "/tapchat.sh"]  

