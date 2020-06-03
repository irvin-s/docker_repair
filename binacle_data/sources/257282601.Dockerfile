FROM mhart/alpine-node:4.3.2

WORKDIR /usr/local/lib
COPY package.json .
RUN npm install
ENV NODE_PATH /usr/local/lib/node_modules

WORKDIR /app
CMD /bin/sh
