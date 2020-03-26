FROM node:7.10-alpine  
  
# install webpack, and jess at once  
RUN npm install webpack jest -g --quiet  
  
WORKDIR /tmp  
COPY package.json /tmp/  
RUN npm config set registry http://registry.npmjs.org/ && npm install --quiet  
  
WORKDIR /usr/src/app  
COPY . /usr/src/app/  
RUN cp -a /tmp/node_modules /usr/src/app/  
  
# permission all files under /usr/src/app to node  
# this user comes by default with the node parent docker image  
RUN chown -R node /usr/src/app  
  
# run as non-root user  
USER node  
  
# package the content based on webpack.config.js  
RUN webpack --config config/webpack.config.js  
  
# tell npm to run in prod mode  
ENV NODE_ENV=production  
  
# start node  
CMD ["npm", "start"]  
EXPOSE 8080  

