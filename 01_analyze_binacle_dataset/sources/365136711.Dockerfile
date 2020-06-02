FROM quay.io/assemblyline/alpine:3.6 as dev

ENV APP_NAME=pact-messages \
    BUNDLE_SILENCE_ROOT_WARNING=1

WORKDIR /app/

COPY .ruby-version ./
RUN apk add --no-cache \
        ca-certificates \
        git \
        build-base \
        ruby$(cat .ruby-version) \
        ruby$(cat .ruby-version)-dev
COPY Gemfile Gemfile.lock pact-messages.gemspec ./
RUN bundle install -j4 -r3
COPY . .
