FROM node:6-alpine  
  
MAINTAINER Darren Oakley <daz.oakley@gmail.com>  
  
ENV APP_HOME /app  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
  
COPY package.json package.json  
COPY package-lock.json package-lock.json  
RUN npm install  
  
COPY . .  
  
EXPOSE 80  
CMD ["bin/thundermole", "--port", "80"]  

