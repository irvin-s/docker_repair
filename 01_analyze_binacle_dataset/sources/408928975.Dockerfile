FROM ruby:2.4

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

WORKDIR /src

COPY Gemfile extreme_timeout.gemspec /src/
RUN bundle install -j$(nproc)

COPY Rakefile /src/
COPY ext/extreme_timeout/extconf.rb ext/extreme_timeout/extreme_timeout.c /src/ext/extreme_timeout/
RUN bundle exec rake compile

COPY . /src

RUN ["/bin/bash"]
CMD ["bundle", "exec", "rspec", "-f", "d", "spec"]
