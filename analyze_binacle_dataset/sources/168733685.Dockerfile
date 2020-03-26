FROM ruby:2.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /service
WORKDIR /service

COPY Gemfile /service/
COPY . /service/

RUN bundle install


ENTRYPOINT ["/service/bin/start.rb"]
CMD ["pong"]

EXPOSE 8080