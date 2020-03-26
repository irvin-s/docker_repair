FROM node:carbon  
# Install app dependencies  
RUN git clone https://github.com/DaniyalMarghoob/darksky-collector/ && \  
cd darksky-collector  
  
WORKDIR darksky-collector  
RUN npm install  
CMD [ "node", "index.js" ]  

