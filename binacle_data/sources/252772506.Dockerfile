FROM node:6.1  
RUN mkdir src/  
  
WORKDIR /src  
  
COPY . /src  
  
ENV NODE_ENV production  
  
RUN cd /src; npm install; npm run build  
  
expose 3000  
CMD ["npm", "run", "runProd"]  

