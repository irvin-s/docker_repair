# Ruby/Rails Dev Environment (gewo/ruby:2.1.0)
FROM gewo/ruby-dependencies
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV APP_RUBY_VERSION 2.1.0
RUN rvm install ruby-${APP_RUBY_VERSION} --default
CMD ["/bin/bash"]
