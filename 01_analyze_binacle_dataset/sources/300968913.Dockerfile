FROM node

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app
RUN npm install
COPY . /usr/src/app

ENV NODE_ENV production

EXPOSE 8080
CMD ["npm", "run", "start:prod"]

