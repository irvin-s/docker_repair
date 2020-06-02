FROM ruby:2.1.5
MAINTAINER Ross Fairbanks "ross@rossfairbanks.com"

RUN apt-get update

# Cache installing gems
WORKDIR /tmp
ADD Gemfile* /tmp/
RUN bundle install

# Create an app user
RUN useradd --create-home --home-dir /app --shell /bin/bash app

# Add app code
WORKDIR /app
ADD . /app
RUN chown -R app:app /app

USER app

# Default to starting the server
CMD ["bundle", "exec", "rake", "hello:server"]
