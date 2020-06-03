FROM ruby

COPY Gemfile /tmp/

RUN cd /tmp && bundle install