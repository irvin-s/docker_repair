# this Dockerfile expects the root of the project to be its context, e.g.:
# docker build -f ./expander/ruby-multithreaded/Dockerfile .
FROM ruby:2.5.0-alpine

RUN mkdir -p /app/expander/ruby-multithreaded
WORKDIR /app/expander/ruby-multithreaded
ADD ./expander/ruby-multithreaded/Gemfile ./Gemfile
ADD ./expander/ruby-multithreaded/Gemfile.lock ./Gemfile.lock
RUN bundle

WORKDIR /app
ADD ./lib ./lib
ADD ./expander/ruby-multithreaded ./expander/ruby-multithreaded
WORKDIR /app/expander/ruby-multithreaded

CMD [ "ruby", "server.rb" ]

EXPOSE 10000
