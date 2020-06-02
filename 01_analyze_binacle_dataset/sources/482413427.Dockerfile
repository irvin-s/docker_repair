FROM zenika/alpine-node

ONBUILD COPY package.json yarn.lock /usr/src/app/
ONBUILD RUN yarn
ONBUILD COPY . /usr/src/app

CMD [ "yarn", "start" ]
