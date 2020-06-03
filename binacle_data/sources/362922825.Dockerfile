FROM ruby:latest
MAINTAINER Will Sloan <sloan.848@osu.edu>

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/ 
RUN bundle install

CMD ["./scrape.rb"]
