FROM node:alpine

COPY . /sensors
WORKDIR /sensors
RUN npm i

CMD [ "node", "/sensors/index" ]