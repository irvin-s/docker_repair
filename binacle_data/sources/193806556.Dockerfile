FROM ruby:2.1.5
ENV LANG C.UTF-8

# For execjs to compile assets
RUN apt-get update && apt-get install -y nodejs default-jre && rm -rf /var/lib/apt/lists/*

RUN gem install foreman
CMD foreman start

ENV PORT 5000
ENV RACK_ENV production
ENV MEMCACHE_SERVERS memcache.clearbit.io

EXPOSE 5000

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN mkdir -p tmp

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app
RUN mkdir -p tmp

CMD foreman start
