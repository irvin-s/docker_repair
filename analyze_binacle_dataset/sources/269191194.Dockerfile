FROM node:6.11.1
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 3000
CMD [ "npm", "start" ]
