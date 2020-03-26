FROM node:6 
RUN npm i -g typescript 
RUN npm i -g tslint 
RUN npm i -g webpack 

# GOPATH
WORKDIR /srv/boil
