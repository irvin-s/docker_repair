FROM node:carbon-alpine

# Create app directory
WORKDIR /usr/src/app

ENV PORT=3000

COPY package.json .

RUN npm install --production

COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]
