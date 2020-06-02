FROM node:0.12  
RUN npm install -g api-mock  
  
ENV PORT=3000  
ENV MD_PATH=./apiary.md  
  
RUN mkdir -p /usr/src/api-mock  
WORKDIR /usr/src/api-mock  
  
CMD api-mock $MD_PATH \--port $PORT  

