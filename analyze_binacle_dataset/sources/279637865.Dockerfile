FROM node:8.6.0

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

# Bundle app source
COPY . .

EXPOSE 80
CMD [ "node", "index.js" ]
