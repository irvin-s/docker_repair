FROM node:6.5.0

RUN curl -SLO https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && bzip2 -d phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    && tar -xvf phantomjs-2.1.1-linux-x86_64.tar -C /usr/local \
    && rm -f phantomjs-2.1.1-linux-x86_64.tar \
    && ln -s /usr/local/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

RUN curl -SLO https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && mv wait-for-it.sh /usr/local/bin \
    && chmod 700 /usr/local/bin/wait-for-it.sh

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY . /usr/src/app

CMD npm install && wait-for-it.sh -t 0 node-external-apvs:3000 -- node test-wcag-aa.js
