FROM mhart/alpine-node:11

WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
CMD node ./bin/cli
