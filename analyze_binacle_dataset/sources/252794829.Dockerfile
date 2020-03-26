FROM node:8.11.1  
WORKDIR /usr/app  
COPY . .  
RUN chown -R node.node .  
USER node  
RUN ./dockerinstall.sh  
USER root  
RUN chown -R root.root .  
EXPOSE 8080  
USER node  
CMD ["/usr/app/packages/server/musicociel-server"]  

