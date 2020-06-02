FROM node:carbon  
  
# Install app dependencies  
RUN git clone https://github.com/DaniyalMarghoob/nodeGrafana/ && \  
cd nodeGrafana  
  
WORKDIR nodeGrafana  
RUN npm install --production --unsafe-perm  
EXPOSE 3000  
CMD [ "node", "index.js" ]  

