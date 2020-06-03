FROM node:boron  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY . /usr/src/app  
RUN npm install  
  
EXPOSE 3008  
CMD [ "npm", "start" ]

