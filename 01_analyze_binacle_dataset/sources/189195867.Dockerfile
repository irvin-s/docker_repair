#BUILD_PUSH=hub,quay
# https://registry.hub.docker.com/_/ruby/
FROM ruby:latest

RUN apt-get update \
    && apt-get -yqq --no-install-recommends install ruby-full rubygems git-core less \
    && rm -rf /var/lib/apt/lists/*

RUN gem install rhc

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
