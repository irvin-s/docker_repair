FROM quay.io/evman/environment

COPY --chown=ruby:root Gemfile Gemfile.lock ./

RUN bundle install --deployment --without=test development

COPY --chown=ruby:root docker/evman.sh Rakefile config.ru package.json yarn.lock .babelrc ./

COPY --chown=ruby:root bin ./bin
COPY --chown=ruby:root config ./config
COPY --chown=ruby:root app ./app
COPY --chown=ruby:root db ./db
COPY --chown=ruby:root lib ./lib
COPY --chown=ruby:root public ./public

RUN ./assets.sh