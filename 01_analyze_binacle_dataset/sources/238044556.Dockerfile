FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y jekyll bundler

RUN mkdir /deeprefactoring
WORKDIR /deeprefactoring
COPY Gemfile* ./
RUN bundle install
RUN rm Gemfile*

CMD ["jekyll", "serve"]
