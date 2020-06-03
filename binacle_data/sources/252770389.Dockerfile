FROM node:latest  
  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY ./package.json /app/package.json  
RUN npm install  
  
COPY . /app  
  
EXPOSE 3000  
ENTRYPOINT ["npm"]  
CMD ["start"]  

