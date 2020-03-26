FROM area51/node:latest  
MAINTAINER Peter Mount <peter@retep.org>  
  
ENV CMD=/opt/notify-rabbit.js  
  
COPY config.js /opt/  
COPY config.yaml /opt/  
COPY notify-rabbit.js /opt/  
COPY package.json /opt/  
  
WORKDIR /opt  
  
CMD $CMD  
  
RUN npm install &&\  
chmod +x $CMD  

