FROM node:7.8.0
COPY / /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000
CMD npm start
