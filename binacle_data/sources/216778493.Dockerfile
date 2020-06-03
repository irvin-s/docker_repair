FROM mhart/alpine-node
COPY package.json /api/package.json
WORKDIR /api
RUN npm install
