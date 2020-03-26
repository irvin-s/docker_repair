# Docker image for the drone-chef plugin
#
#     docker build --rm=true -t jmccann/drone-chef .

FROM alpine:3.4

# Install required packages
RUN apk update && \
  apk add \
    ca-certificates \
    git \
    ruby && \
  gem install --no-ri --no-rdoc \
    bundler --version '~> 1.13' && \
  rm -rf /var/cache/apk/*

# Install gems
RUN echo 'gem: --no-rdoc --no-ri' > ~/.gemrc
COPY drone-chef.gemspec drone-chef.gemspec
COPY Gemfile Gemfile
RUN apk update && \
  apk add \
    ruby-dev \
    build-base \
    perl \
    libffi-dev \
    bash && \
  # Required for bundler
  gem install --no-ri --no-rdoc \
    io-console --version '~> 0.4' && \
  bundle install --without development test && \
  apk del \
    ruby-dev \
    build-base \
    bash \
    libffi-dev \
    perl && \
  rm -rf /var/cache/apk/*

# Install plugin
COPY drone-chef-0.0.0.gem /tmp/
RUN gem install --no-ri --no-rdoc --local \
  /tmp/drone-chef-0.0.0.gem

ENTRYPOINT ["/usr/bin/drone-chef", "upload"]
