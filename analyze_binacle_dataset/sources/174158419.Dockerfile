FROM node:10
MAINTAINER M. Peter <mp@tcs.de>

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y build-essential

RUN apt-get -y install redis-server

RUN	mkdir -p /usr/src/
WORKDIR /usr/src/

COPY package.json /usr/src/package.json

RUN npm install -g mocha
RUN npm install 

COPY lib/ /usr/src/lib/
COPY test/ /usr/src/test/
COPY index.js /usr/src/
COPY dockertests/test.sh /usr/src/test.sh

RUN chmod +x /usr/src/test.sh

CMD [ "/usr/src/test.sh" ]
