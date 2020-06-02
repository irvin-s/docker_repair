# react 14.4 app  
FROM node:4.2.1  
MAINTAINER Andrew Grewell <andrewgrewell@gmail.com>  
  
ENV NODE_ENV production  
  
WORKDIR /  
  
COPY package.json package.json  
RUN npm install --unsafe-perm # See https://github.com/npm/npm/issues/2984  
  
COPY . /  
RUN npm run build  
RUN rm -rf .git  
  
EXPOSE 3000  
CMD ["node", "initServer.js"]

