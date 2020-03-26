FROM ruby:2.3.0

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update -qq \
    && apt-get install -y build-essential libpq-dev postgresql-client-9.5 postgresql-contrib-9.5


ENV APP_PATH=/app BUNDLE_JOBS=4 BUNDLE_RETRY=3 BUNDLE_PATH=/gems

RUN mkdir ${APP_PATH}
WORKDIR ${APP_PATH}

ADD . ${APP_PATH}

CMD bundle check || bundle install; bundle exec rspec spec
