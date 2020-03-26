FROM node:argon

WORKDIR /gdoc-publisher
ADD package.json /gdoc-publisher/package.json
RUN npm install
ADD . /gdoc-publisher
