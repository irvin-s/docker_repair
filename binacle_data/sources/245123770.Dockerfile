FROM node:7.1-alpine

RUN apk add --no-cache bash python=2.7.12-r0 make gcc g++

RUN npm install --quiet --global @angular/cli@1.0.0

EXPOSE 4200/tcp

WORKDIR /app
COPY package.json /app/package.json
RUN npm install --quiet

RUN mkdir dist
#CMD ["npm", "start"]