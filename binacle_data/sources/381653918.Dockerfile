FROM ctac/ruby-base:2.1

ENV APP_HOME /social_media

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install git nodejs -y --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update \
  && apt-get install -y --no-install-recommends g++ \
  && rm -rf /var/lib/apt/lists/*

ADD Gemfile* $APP_HOME/

ARG RAILS_ENV=production

RUN bundle install --jobs 4

ADD . $APP_HOME

RUN mkdir public/assets && \
  mkdir tmp && \
  mkdir tmp/pids

RUN chmod a+t /usr/local/bundle && \
  chmod a+t /usr/local/bundle/bin && \
  rm -rf /usr/local/bundle/gems/swagger-docs-0.2.8/spec/

ARG REGISTRY_HOSTNAME=unprovided.domain
ARG REGISTRY_API_HOST=https://unprovided.domain

RUN bundle exec rake assets:precompile

EXPOSE 80
ENTRYPOINT [ "unicorn", "-c", "config/unicorn.rb" ]
