FROM codelittinc/node

RUN mkdir -p /share
WORKDIR /share

ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY package.json /share/
ONBUILD COPY . /share
ONBUILD RUN npm install

CMD [ "npm", "start" ]
