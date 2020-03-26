FROM node:7.1.0  
# install gulp-cli  
RUN npm install -g gulp-cli  
  
# create 'app' folder  
RUN mkdir /app  
  
# copy to 'app' folder  
COPY /app/ /app/  
  
# set work directory  
WORKDIR /app  
  
# install dependencies and build app  
RUN npm install && gulp build  
  
# expose port '3000'  
EXPOSE 3000  
# set entrypoint to run the server  
ENTRYPOINT [ "npm", "start" ]  

