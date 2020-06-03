FROM node

RUN apt-get update

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install --unsafe-perm
COPY . /usr/src/app
#RUN grunt deploy

CMD [ "npm", "start" ]
EXPOSE 9000