FROM ruby:2.2.0

RUN apt-get update && apt-get install -y nodejs sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4 --without development test production

ADD . /usr/src/app

ENV RAILS_ENV preview
RUN bundle exec rake db:create && \
    bundle exec rake db:migrate && \
    bundle exec rake db:seed_fu && \
    bundle exec rake assets:precompile

EXPOSE 80
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]
