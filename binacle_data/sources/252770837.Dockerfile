FROM node  
  
MAINTAINER Adrián García Espinosa "adri@syncrtc.com"  
# Copy custom configuration  
COPY . /server  
  
WORKDIR /server  
  
RUN npm install  
  
EXPOSE 3000  
  
CMD npm start  

