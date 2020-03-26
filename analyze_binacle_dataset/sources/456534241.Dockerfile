FROM ruby:2.4.1

RUN mkdir -p /test
WORKDIR /test

ADD Gemfile /test/Gemfile
ADD Gemfile.lock /test/Gemfile.lock

RUN bundle install

ADD features /test/features

ENTRYPOINT ["cucumber"]
