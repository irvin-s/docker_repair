FROM ruby:2.5.3
LABEL maintainer="joshua@mcginnis.io"

RUN apt-get update

WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries
RUN gem install bundler && bundle install --jobs 20 --retry 5

WORKDIR /app
ADD . /app

EXPOSE 4567
EXPOSE 9292

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
