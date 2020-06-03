FROM node:6  
# Pull App  
WORKDIR /usr/src  
RUN git clone https://github.com/awesome-oli/node-express-app.git app  
WORKDIR app  
  
# install dependencies  
RUN npm install  
  
EXPOSE 3000  
CMD [ "npm", "start" ]

