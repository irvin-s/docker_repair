FROM node:8

WORKDIR /usr/src/wip
COPY package*.json ./
RUN npm install -g nodemon
RUN npm install
COPY . .

EXPOSE 3000
CMD [ "nodemon"]
