FROM keymetrics/pm2:latest-alpine

COPY package.json .

RUN npm install --production

COPY pm2.json .

WORKDIR /

EXPOSE 3000 8080 9229

COPY . .
