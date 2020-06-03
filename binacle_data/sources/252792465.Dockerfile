FROM node:0.12.9  
  
RUN mkdir -p /service  
WORKDIR /service  
  
ONBUILD ADD . /service  
ONBUILD RUN npm install -g grunt-cli  
ONBUILD RUN npm install  
ONBUILD RUN grunt build  
  
CMD [ "npm", "start" ]  

