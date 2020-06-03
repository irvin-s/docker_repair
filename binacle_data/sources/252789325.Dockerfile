FROM mhart/alpine-node:8  
RUN mkdir /app  
ADD . /app  
WORKDIR /app  
RUN ls  
RUN npm install  
  
EXPOSE 8080  
CMD ["npm", "start"]  

