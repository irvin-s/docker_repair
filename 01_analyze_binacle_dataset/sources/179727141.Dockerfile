FROM ruby:2.2.0
RUN mkdir -p /usr/local/bundle
RUN apt-get update
RUN apt-get -y install apt-utils nodejs
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000

# RUN bundle update
RUN bundle install
