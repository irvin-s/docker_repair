FROM node

RUN npm install jilla
ENV PATH ${PATH}:/node_modules/.bin
