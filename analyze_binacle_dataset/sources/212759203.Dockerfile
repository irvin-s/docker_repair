FROM node:argon

# Create app directory
RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/config
WORKDIR /usr/src/app

RUN npm install pm2 -g
# Install app dependencies
COPY ./package.json /usr/src/app/
RUN npm install

COPY ./client /usr/src/app/client
COPY ./process.json /usr/src/app/
COPY ./config /usr/src/app/config
COPY ./common-util /usr/src/app/common-util
COPY ./gateway-service /usr/src/app/gateway-service

EXPOSE 3000

CMD pm2 start --no-daemon  process.json --only gateway-service --env docker