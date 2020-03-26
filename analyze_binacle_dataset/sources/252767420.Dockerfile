FROM node:latest  
MAINTAINER Alex Plescan  
  
ENV UPDATE_FREQUENCY_SECONDS 600  
ADD . /app  
WORKDIR /app  
  
RUN chmod u+x run.sh  
  
RUN npm install  
  
CMD ./run.sh  

