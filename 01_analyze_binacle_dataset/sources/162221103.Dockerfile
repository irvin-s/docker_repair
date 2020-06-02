FROM ruby:alpine

COPY . /app
WORKDIR /app

RUN \
  apk update && \
  apk add build-base && \
  gem build coap.gemspec && \
  gem install coap-*.gem && \
  apk del build-base && \
  rm /var/cache/apk/*.gz

ENTRYPOINT ["coap"]
