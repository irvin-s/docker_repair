FROM ruby:2.5

ARG app_env
ENV APP_ENV ${app_env:-production}
ENV RAILS_ENV $APP_ENV

ENV APP_HOME /usr/local/rocket_answer
WORKDIR $APP_HOME

# Install gems
# COPY vendor/bundle vendor/bundle
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY scripts/bundle_install.sh scripts/bundle_install.sh
RUN /bin/sh scripts/bundle_install.sh

# Prepare App
COPY . $APP_HOME

# Remove Cache
RUN rm -rf vendor/bundle/ruby/*/cache
RUN bundle clean

# Assets Precompile
# 仮のSECRET_KEY_BASE
ENV SECRET_KEY_BASE 0b863d8ea897321e28c6d862c74377c4a7abda3a77c5df73d1211921ab2027f346268862261be8e435732b2a3fa3ec11a2c18c8f2c492de4596af69e059370d1
RUN if [ $RAILS_ENV = "production" ]; then bundle exec rails assets:precompile --trace; fi

ENV SECRET_KEY_BASE 12345

## Expose assets for web container
VOLUME $APP_HOME/public/assets

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
