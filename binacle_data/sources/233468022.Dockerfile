FROM ruby:2.3

# Create app directory
RUN mkdir -p /src/app
WORKDIR /src/app

# Install app dependencies
COPY Gemfile /src/app/
COPY Gemfile.lock /src/app/
RUN apt-get update && apt-get -y install build-essential libpq-dev nodejs
RUN bundle install

COPY . /src/app

RUN bundle exec rake db:create db:schema:load --trace
RUN bundle exec rake db:migrate

EXPOSE 3000

CMD ["bin/rails", "server"]
