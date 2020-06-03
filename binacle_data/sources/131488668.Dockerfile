FROM jruby:1.7.19-jdk
RUN mkdir -p /app
WORKDIR /app
ADD Gemfile.lock /app/
ADD Gemfile /app/
ADD smartystreets.gemspec /app/
RUN mkdir -p /app/lib/smartystreets
ADD lib/smartystreets/version.rb /app/lib/smartystreets/
RUN bundle install -j8
ADD . /app
