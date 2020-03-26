# --- Select the image you'd like to use locally
FROM ruby:2.5.1-alpine3.7
# FROM heroku/heroku:18-build

# --- For Alpine image
RUN apk update
RUN apk add \
  bash \
  build-base \
  git \
  nodejs \
  python3 \
  postgresql-dev \
  postgresql-client \
  tzdata \
  yarn \
  && rm -rf /var/cache/apk/*

# --- For Heroku image
# RUN apt-get update && apt-get install -y \
#   bash \
#   build-base \
#   nodejs \
#   python3 \
#   postgresql-dev \
#   postgresql-client \
#   tzdata \
#   yarn \
#   && rm -rf /var/cache/apk/*


# First copy the bundle files and install gems to aid caching of this layer
WORKDIR /tmp
COPY Gemfile* /tmp/
RUN bundle install

ENV app /dtv
RUN mkdir $app
WORKDIR $app
ADD . $app

EXPOSE 3000