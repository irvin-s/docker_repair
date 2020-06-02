FROM node:4.2  
RUN git clone https://github.com/onedr0p/manage-this-node.git /opt/manage-this  
  
WORKDIR /opt/manage-this  
  
RUN npm install  
  
VOLUME /config  
  
RUN ln -sf /config/config.json /opt/manage-this/config.json  
  
EXPOSE 3000  
CMD ["npm", "start"]  

