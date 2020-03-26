FROM node:10

ENV CI=true

COPY . /usr/src/app/
WORKDIR /usr/src/app/packages/kauri-web
RUN yarn install
WORKDIR /usr/src/app/packages/kauri-components
RUN yarn install

EXPOSE 6006
CMD "yarn" "test:chromatic"
