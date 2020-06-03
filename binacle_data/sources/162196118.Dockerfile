FROM ruby:2.5.0

# needed for lib/database_helper.rb
RUN echo deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt update && apt install --yes postgresql-client-10

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

ENV PORT 9292
ENV DATABASE_URL postgres://postgres@citygram_services_db/citygram_services

CMD bundle exec rackup -s puma -o 0.0.0.0 -p $PORT
