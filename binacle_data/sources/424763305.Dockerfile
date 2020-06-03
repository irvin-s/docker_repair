# DOCKER-VERSION 0.3.4
FROM peenuty/nodejs-npm-sass-docker

MAINTAINER Paul Thrasher "thrashr888@gmail.com"


WORKDIR /src

ADD package.json /src/
RUN npm install

ADD Gemfile /src/
RUN bash -l -c "bundle install"

ADD . /src

RUN bower install --allow-root

EXPOSE  9000

CMD cd /src; grunt server build