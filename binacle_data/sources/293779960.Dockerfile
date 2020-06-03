FROM mhart/alpine-node:7.4
RUN mkdir -p /app
WORKDIR /app
ONBUILD COPY package.json package.json
ONBUILD RUN npm install