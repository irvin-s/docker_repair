FROM node:4-slim
MAINTAINER Eoin Shanaghy <eoin.shanaghy@gmail.com>

RUN mkdir /node-seneca-base
COPY package.json /node-seneca-base
WORKDIR /node-seneca-base
RUN npm install
COPY . /node-seneca-base
RUN npm link

RUN mkdir /src
WORKDIR /src
ONBUILD COPY package.json /src/
ONBUILD RUN npm link node-seneca-base
ONBUILD RUN npm install
ONBUILD COPY . /src/
ONBUILD WORKDIR /src

CMD ["node", "/src/index.js"]
