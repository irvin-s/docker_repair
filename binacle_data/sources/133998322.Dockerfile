FROM mhart/alpine-node:6

RUN apk add --no-cache make gcc g++ python

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

RUN npm install pm2 -g

# Bundle app source
COPY . /usr/src/app

EXPOSE 8000

CMD [ "pm2-docker", "app.js" ]

