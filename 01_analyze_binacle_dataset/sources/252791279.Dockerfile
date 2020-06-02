FROM node  
  
ADD . /prime  
WORKDIR /prime  
  
RUN npm install  
  
ENTRYPOINT ["npm","run"]  
  
EXPOSE 8080  
CMD ["dev"]  

