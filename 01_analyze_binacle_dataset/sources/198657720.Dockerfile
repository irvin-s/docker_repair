FROM node:0.12.7

RUN mkdir -p /user/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN npm install

EXPOSE 3000

CMD [ "npm", "start" ]