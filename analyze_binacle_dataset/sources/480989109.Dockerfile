FROM node:5

RUN mkdir /rome
WORKDIR /rome

ADD ./package.json /rome/package.json
RUN npm install

ADD . /rome