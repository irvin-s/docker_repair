FROM node:8.9.1

MAINTAINER yvanwang googolewang@gmail.com

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
COPY package*.json /tmp/
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/recatch-service

# From here we load our application's code in, therefore the previous docker
# "layer" thats been cached will be used if possible
WORKDIR /usr/src/recatch-service
COPY . .
RUN cp -a /tmp/node_modules /usr/src/recatch-service && npm run build

#RUN npm install -g cross-env pm2-docker
RUN npm install pm2 -g

EXPOSE 8082

#RUN container run command
CMD ["npm", "run", "start:docker"]