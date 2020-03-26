FROM node:6.9.1  
RUN mkdir /src  
COPY . /src  
WORKDIR /src  
  
RUN npm install  
  
ENTRYPOINT ["./docker-start.sh"]

