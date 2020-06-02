FROM ruby:2.6.3-slim
MAINTAINER Nick Kugaevsky "nick@kugaevsky.ru"

# Build-time metadata as defined at http://label-schema.org

RUN apt-get update -qq
RUN apt-get install -y curl software-properties-common libpq-dev libxml2-dev libxslt1-dev optipng jpegoptim

# for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y nodejs yarn

# Install latest rubygems, bundler and rake
RUN gem install rubygems-update
RUN update_rubygems
RUN gem update --system
RUN gem install bundler rake pry

ENV APP_HOME /it52
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD package.json $APP_HOME/
ADD yarn.lock $APP_HOME/
RUN yarn

ADD . $APP_HOME

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="IT52" \
      org.label-schema.description="IT52 rails application" \
      org.label-schema.url="https://www.it52.info" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/nnrug/it52-rails" \
      org.label-schema.vendor="IT52" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

CMD [ "bundle", "exec", "rails", "console" ]
