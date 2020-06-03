FROM ruby:2.5
RUN apt-get update -y && apt-get install -y cmake

# Set default locale for Ruby to avoid encoding errors
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /app

RUN gem update --system
RUN gem install bundler

COPY . .
RUN bundle install

# makes the circlemator binstub accessible outside this bundle
RUN rake install:local

ENTRYPOINT ["circlemator"]
