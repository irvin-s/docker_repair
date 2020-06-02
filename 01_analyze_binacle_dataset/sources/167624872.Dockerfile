FROM ruby:2.0

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app
COPY deploy/env /usr/src/app/.env

EXPOSE 9292
CMD ["bundle", "exec", "puma", "-e", "production"]
