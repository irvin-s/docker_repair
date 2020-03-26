FROM node:8.1.3-alpine  
RUN apk update && apk add graphicsmagick  
ADD ./package.json /muralmalvinas/  
WORKDIR /muralmalvinas/  
RUN npm install  
ADD . /muralmalvinas/  
CMD ["npm","run", "start"]  

