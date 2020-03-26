FROM node:6  
WORKDIR /root  
ENV HOME /root  
COPY socket.js ./  
COPY package.json ./  
RUN npm install  
EXPOSE 8011  
ENTRYPOINT [ "node" ]  
CMD [ "socket.js" ]  

