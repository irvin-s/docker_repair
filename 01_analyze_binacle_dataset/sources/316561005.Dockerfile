FROM ruby:2.5.1-alpine

ARG DISABLE_COMPILE

ENV BUNDLE_JOBS=4 RAILS_LOG_TO_STDOUT=true RAILS_SERVE_STATIC_FILES=true

COPY --from=node:10.9.0-alpine /usr/local /usr/local
COPY --from=node:10.9.0-alpine /opt /opt

RUN apk update && apk add --no-cache build-base postgresql-dev tzdata less

RUN adduser -u 1000 -D app
RUN mkdir /app
RUN chown -R app /app

WORKDIR /app

USER app

COPY --chown=app Gemfile Gemfile.lock ./

RUN bundle install

COPY --chown=app package.json yarn.lock ./

RUN if [ -z "$DISABLE_COMPILE" ]; then \
  yarn install \
  ;fi

COPY --chown=app . ./

RUN if [ -z "$DISABLE_COMPILE" ]; then \
  yarn run apollo:codegen && SECRET_KEY_BASE=`bin/rails secret` RAILS_ENV=production bin/rails assets:precompile \
  ;fi

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
