FROM ruby:2.4.1-alpine

RUN apk update && apk --update add tzdata ca-certificates libssl1.0 openssl libstdc++

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base openssl-dev && \
    gem install bundler --no-ri --no-rdoc && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD . /app
USER nobody
ENV PATH="/app/bin:${PATH}"

WORKDIR /app

CMD ["prod"]
