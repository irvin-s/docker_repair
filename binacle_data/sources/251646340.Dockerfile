FROM node:argon

RUN mkdir -p /src
WORKDIR /src
COPY package.json /src/
RUN npm install

COPY *.js /src/
ENTRYPOINT ["node", "server.js"]

