FROM node:6.3

WORKDIR /project/client

COPY package.json /project/client
RUN npm install

COPY . /project/client

EXPOSE 3000
