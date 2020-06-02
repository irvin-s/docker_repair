FROM node:5.2

RUN mkdir /app

WORKDIR /app
COPY package.json ./
RUN npm install

COPY . ./

CMD ["node", "sonarr.js"]
