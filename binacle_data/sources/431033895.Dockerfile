FROM ruby:2.5.1-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN apk add --no-cache --update alpine-sdk && \
    bundle install && \
    apk del alpine-sdk
COPY . /usr/src/app
COPY config/mongoid-docker.yml config/mongoid.yml
EXPOSE 3000
CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]
