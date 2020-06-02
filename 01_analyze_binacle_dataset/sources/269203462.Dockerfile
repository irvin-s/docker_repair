FROM ruby:2.4-slim

# set some rails env vars
ENV BUNDLE_PATH /bundle
# set the app directory var
ENV APP_HOME /home/app
WORKDIR $APP_HOME

RUN apt-get update -qq
# Install apt dependencies
RUN apt-get install -y nodejs

RUN apt-get install -y --no-install-recommends \
  build-essential \
  curl libssl-dev \
  git \
  unzip \
  zlib1g-dev \
  libxslt-dev \
  libsqlite3-dev \
  mysql-client \
  libmysqlclient-dev \
  sqlite3
# install bundler
RUN gem install bundler
COPY Gemfile* ./
RUN bundle install
ADD . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
