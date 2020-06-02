FROM node:10

WORKDIR /usr/src/app

COPY package.json package-lock.json /usr/src/app/

RUN npm install

COPY . /usr/src/app

CMD ["npm", "run", "dev"]
