FROM node:8.7.0-alpine

RUN apk add --no-cache python gcc g++ make git

RUN mkdir /log

# install smart-contracts dependencies
WORKDIR /app/smart-contracts
COPY package.json /app/smart-contracts/package.json
COPY package-lock.json /app/smart-contracts/package-lock.json
RUN npm install

# add smart-contracts source code, need to put contracts/ in main dir
COPY src/ /app/smart-contracts/

# we want two functionalities: 1. run tests 2. deploy to some net
CMD ["npm", "run", "deploy"]
