# Dockerfile to include the example to the overall tests of qix-graphql on CircleCI

FROM node

ENV HOME_DIR "opt/qix-graphql/examples/node.js"

RUN mkdir -p $HOME_DIR
WORKDIR $HOME_DIR

COPY package.json ./

RUN npm config set loglevel warn
RUN npm install --quiet --no-package-lock

COPY . .

RUN ["npm", "run", "start"]
