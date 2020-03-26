FROM ruby:2.5.3-alpine3.8
MAINTAINER Joseph Nelson Valeros

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                tzdata

WORKDIR /app
RUN gem install bundler
ADD Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5 --without development test

COPY . ./
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
