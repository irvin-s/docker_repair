FROM jruby:9.1-jre-alpine

ADD . /exporter
WORKDIR /exporter
RUN bundler install --deployment --jobs=4

EXPOSE 8080

ENV RAILS_ENV=production

CMD bundle exec rails server -b 0.0.0.0
