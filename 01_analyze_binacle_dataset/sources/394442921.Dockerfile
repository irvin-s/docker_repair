FROM quay.io/netguru/ng-ruby:2.5.1

## Passenger
RUN /opt/passenger/install

## Node
RUN \
  curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs

## YARN
RUN \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

## bundle dependencies
RUN apt-get update && apt-get install -y libpq-dev

ENV APP_HOME /var/www/app
ENV RAILS_ENV=production
ENV REDIS_URL=redis://redis:6379/0

## set timezone
RUN echo 'Europe/Warsaw' > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

## throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --jobs=8 --retry=3 --without development test --deployment

ADD . $APP_HOME/
ADD docker/production/entrypoint.sh /entrypoint.sh
ADD docker/production/service/sidekiq /etc/service/sidekiq/run

RUN yarn
RUN npm run build
RUN rm -rf node_modules

# set cron tasks
RUN bundle exec whenever --update-crontab --set environment=production

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/my_init"]

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
