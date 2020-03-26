FROM ruby:2.4-alpine

# set some rails env vars
ENV RAILS_ENV production
ENV BUNDLE_PATH /bundle
ENV APP_HOME /home/solidus

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apk add --update \
  build-base \
  imagemagick \
  file \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  nodejs

COPY Gemfile* ./
RUN bundle install

ADD . .

EXPOSE 3000
CMD ["/sbin/my_init"]
