FROM node:argon  
  
MAINTAINER Shawn Seymour <seymo079@morris.umn.edu>  
MAINTAINER Dan Stelljes <stell124@morris.umn.edu>  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app  
RUN npm install  
COPY . /usr/src/app  
  
EXPOSE 9001  
CMD ["npm", "start"]  

