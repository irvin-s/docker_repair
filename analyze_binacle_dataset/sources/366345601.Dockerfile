FROM ruby:2.2

COPY ./ruby-cli-app /app
RUN cd /app \
 && bundle install

ENTRYPOINT ["ruby-cli-app"]
