FROM fluent/fluentd:v1.1.0
RUN apk add --update --no-cache build-base ruby-dev \
  && fluent-gem install fluent-plugin-prometheus --version=1.0.1 \
  && fluent-gem install fluent-plugin-elasticsearch --version=2.11.2 \
  && gem sources --clear-all \
  && apk del build-base ruby-dev