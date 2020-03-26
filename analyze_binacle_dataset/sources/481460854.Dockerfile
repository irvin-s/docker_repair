FROM node:argon
RUN npm install -g lodash
RUN npm install -g bluebird
RUN npm install -g webpack


# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install
RUN npm install --save lodash

# Bundle app source
COPY . /usr/src/app

EXPOSE 6379
EXPOSE 3000

RUN webpack
CMD [ "npm", "start" ]

