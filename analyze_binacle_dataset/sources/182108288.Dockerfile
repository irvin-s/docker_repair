FROM ubuntu:trusty
MAINTAINER William Blankenship <wblankenship@nodesource.com>

# Setup NodeSource Official PPA
RUN apt-get update && \
    apt-get install -y --force-yes \
      curl \
      apt-transport-https \
      lsb-release \
      build-essential \
      python-all

RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get update
RUN apt-get install nodejs -y --force-yes

RUN npm install -g node-gyp \
 && npm cache clear

RUN node-gyp configure || echo ""

COPY . /src
RUN cd /src; npm install

EXPOSE  3000

CMD ["node", "/src/index.js"]
