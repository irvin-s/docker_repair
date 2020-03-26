# Jekyll v3.5
#
# docker run --rm -v $(pwd)/src:/in -v $(pwd)/dist:/out supinf/jekyll:3.5 jekyll build --source /in --destination /out --config /in/config.yaml

FROM ruby:2.4.1-alpine3.6

COPY Gemfile /

RUN apk --no-cache add --virtual build-deps build-base make python git bash \
    && apk --no-cache add --no-cache libstdc++ \
    && echo 'gem: --no-rdoc --no-ri' > ~/.gemrc \
    && gem install libv8 -v 3.16.14.16 -- --with-system-v8 \
    && gem install bundler -v 1.15.4 \
    && bundle install \
    && apk del --purge build-deps
