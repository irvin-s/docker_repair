FROM node:0.10-slim

COPY ./package.json /src/package.json
RUN cd /src && npm install
COPY  ./ /src

WORKDIR /src
#ENV DEBUG=*


CMD ["npm", "start"]

