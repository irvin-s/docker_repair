FROM ruby:2.4-alpine

MAINTAINER Jono Finger <jono@foodnotblogs.com>

ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN apk --no-cache add curl build-base && \
    echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    bundle install --no-cache && \
    apk del build-base && \
    rm -rf /root/.bundle # not sure what this dir does, but it takes up space

COPY . $APP_HOME

CMD ["ruby", "app.rb"]
