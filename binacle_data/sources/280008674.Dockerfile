FROM node:alpine 
WORKDIR /src
COPY ./package.json /src
RUN  npm install 
COPY . /src

CMD  ["node", "/src/index.js"]