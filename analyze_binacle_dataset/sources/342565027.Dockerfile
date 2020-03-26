FROM node:8.7.0-alpine

RUN apk add --no-cache python gcc g++ make git \
# we use nodemon to auto-restart the server when serverside code changes
    && npm install nodemon -g

RUN mkdir /log

# install smart-contracts dependencies
WORKDIR /app/smart-contracts
COPY package.json /app/smart-contracts/package.json
COPY package-lock.json /app/smart-contracts/package-lock.json
RUN npm install

# add smart-contracts source code, need to put contracts/ in main dir
COPY src/ /app/smart-contracts/

# mark deploy shell script as executable
RUN chmod +x ./deploy.sh

# we want two functionalities: 1. run tests 2. deploy to some net,
# default to running deploy, see npm script test:smart-contracts to see how to
# invoke tests
ENTRYPOINT ["npm", "run"]
CMD ["deploy"]
