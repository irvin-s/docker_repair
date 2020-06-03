# this Dockerfile expects the root of the project to be its context, e.g.:
# docker build -f ./expander/ruby-event-machine/Dockerfile .
FROM ruby:2.5.0

RUN mkdir -p /app/expander/ruby-event-machine
WORKDIR /app/expander/ruby-event-machine
ADD ./expander/ruby-event-machine/Gemfile ./Gemfile
ADD ./expander/ruby-event-machine/Gemfile.lock ./Gemfile.lock
RUN bundle

WORKDIR /app
ADD ./lib ./lib
ADD ./expander/ruby-event-machine ./expander/ruby-event-machine
WORKDIR /app/expander/ruby-event-machine

CMD [ "ruby", "server.rb" ]

EXPOSE 10000
