FROM node:slim  
  
COPY . /node  
  
RUN cd /node && \  
npm install  
  
EXPOSE 2126  
EXPOSE 2127  
ENTRYPOINT [ "node", "/node/index.js" ]  

