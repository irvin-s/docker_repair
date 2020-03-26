FROM mhart/alpine-node:6.9.4  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY . /usr/src/app  
RUN npm install && npm install pm2 -g  
  
EXPOSE 3036  
CMD [ "npm", "start" ]

