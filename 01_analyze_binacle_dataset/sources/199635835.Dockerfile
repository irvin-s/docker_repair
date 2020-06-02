FROM ruby:2.5-alpine
MAINTAINER Eguzki Astiz Lezaun <eastizle@redhat.com>

WORKDIR /usr/src/app
COPY . .
RUN gem build 3scale_toolbox.gemspec
RUN gem install 3scale_toolbox-*.gem --no-document
RUN adduser -D toolboxuser -h /home/toolboxuser
WORKDIR /home/toolboxuser

# clean up
RUN rm -rf /usr/src/app

# Drop privileges
USER toolboxuser
