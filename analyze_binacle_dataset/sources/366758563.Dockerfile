# DOCKER-VERSION 1.10

#########################################
###
###	This Dockerfile can be used to build an image that encloses the node_odata_server_example application
###
#########################################

#FROM registry.eu-gb.bluemix.net/ibmnode:4
#FROM node:4-onbuild
FROM node:4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY . /usr/src/app

CMD [ "npm", "start" ]

expose  :3000
