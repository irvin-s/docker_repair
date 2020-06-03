FROM mhart/alpine-node:6

RUN apk update
RUN apk add git

COPY ./harden.sh /usr/local/bin/harden.sh
RUN /usr/local/bin/harden.sh

RUN mkdir /app
WORKDIR /app

COPY package.json /app/
COPY npm-shrinkwrap.json /app/

RUN npm install --production

ADD . /app

EXPOSE 3000
CMD ["node", "index.js"]

