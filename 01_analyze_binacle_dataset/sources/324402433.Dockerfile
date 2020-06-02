FROM node:10

# RUN apt-get update && apt upgrade && \
#   apt install -y bash git openssh-client
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app/packages/kauri-components
RUN yarn install

WORKDIR /usr/src/app/packages/kauri-web
RUN yarn install
RUN npm run build


WORKDIR /usr/src/app/packages/kauri-admin
RUN npm install -g serve
RUN yarn install
ENV NODE_ENV production
RUN npm run build
EXPOSE 5000
CMD "serve" "-s" "build"