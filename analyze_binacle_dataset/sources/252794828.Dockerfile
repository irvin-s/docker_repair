FROM node:8.9.4  
WORKDIR /usr/app  
COPY . .  
RUN chown -R node.node .  
USER node  
RUN ./dockerinstall.sh  
USER root  
RUN chown -R root.root .  
EXPOSE 8080  
USER node

