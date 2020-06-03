FROM node:8

EXPOSE 8080

RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app

ADD . /usr/src/app  
RUN npm install --production  

CMD ["npm", "start"]  
