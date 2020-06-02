FROM ruby:2.2.2
RUN mkdir /app
WORKDIR /app
ADD Gemfile.lock /app/
ADD Gemfile /app/
ADD smartystreets.gemspec /app/
RUN mkdir -p /app/lib/smartystreets
ADD lib/smartystreets/version.rb /app/lib/smartystreets/
RUN bundle install -j8
ADD . /app
