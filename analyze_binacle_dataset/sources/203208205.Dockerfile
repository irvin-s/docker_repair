FROM mhart/alpine-node:6.5.0
WORKDIR /usr/src/app
COPY package.json package.json
RUN npm install
COPY . /usr/src/app
ENTRYPOINT ["node", "cli.js"]
