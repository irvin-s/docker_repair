FROM ruby:2.5.3-alpine3.7

ENV PORT 8080
EXPOSE 8080
WORKDIR /app

RUN apk --no-cache add \
      build-base \
      chromium \
      chromium-chromedriver \
      git \
      nodejs \
      postgresql-dev \
      tzdata \
      bash # debugging and datadog events

COPY .ruby-version Gemfile* ./

RUN gem install bundler && \
    bundle install --frozen --jobs $(nproc)

COPY . ./
RUN adduser -D deploy && \
    chown -R deploy:deploy /app

USER deploy

CMD bundle exec rails server
