FROM node:latest
RUN mkdir /frontend
WORKDIR /frontend
ADD package.json /frontend/
RUN npm install
#ADD . /frontend/
