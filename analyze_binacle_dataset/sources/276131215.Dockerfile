FROM ruby:2.3.1

RUN apt-get -y update && apt-get -y upgrade

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN mkdir -p /opt/coding-challenge-api
WORKDIR /opt/coding-challenge-api

ENV HOME /opt/coding-challenge-api

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
RUN gem install bundler

RUN apt-get -y install imagemagick vim
RUN echo 'alias rails="bundle exec rails"' >> ~/.bashrc

ADD Gemfile /opt/coding-challenge-api
ADD Gemfile.lock /opt/coding-challenge-api

RUN bundle install -j 4