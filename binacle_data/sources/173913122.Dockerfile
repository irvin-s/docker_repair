FROM ruby:2.2.1

RUN apt-get update && apt-get install -qq -y libicu-dev cmake nodejs

RUN mkdir /mana-rails
WORKDIR /mana-rails

ADD Gemfile /mana-rails/Gemfile
ADD Gemfile.lock /mana-rails/Gemfile.lock
RUN bundle install

ADD . /mana-rails
