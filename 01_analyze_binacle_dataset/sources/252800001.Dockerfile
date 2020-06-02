FROM node:alpine  
  
RUN apk add --update-cache git curl &&\  
git clone \--depth 1 https://github.com/ether/etherpad-lite /opt/etherpad &&\  
adduser etherpad || echo "" &&\  
chown -R etherpad:etherpad /opt/etherpad  
  
USER etherpad  
RUN /opt/etherpad/bin/installDeps.sh  
  
EXPOSE 9001  
WORKDIR /opt/etherpad/  
ENTRYPOINT ["/opt/etherpad/bin/run.sh"]  

