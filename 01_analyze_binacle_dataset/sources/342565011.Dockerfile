FROM node:8.7.0-alpine

RUN apk add --no-cache python gcc g++ make git

RUN mkdir /log

# install api dependencies
WORKDIR /app/api
COPY package.json /app/api/package.json
COPY package-lock.json /app/api/package-lock.json
RUN npm install

# add api source code
COPY src/ /app/api/src/

# start production api server
CMD ["npm", "run", "start:prod"]
