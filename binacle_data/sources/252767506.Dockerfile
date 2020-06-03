FROM node:6.11.1-alpine  
  
USER node  
ENV WORK /home/node/work  
RUN mkdir -p $WORK  
COPY . $WORK  
WORKDIR /home/node/work  
  
RUN npm install  
EXPOSE 5000  
CMD [ "node", "index.js" ]  

