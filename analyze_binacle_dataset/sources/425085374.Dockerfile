# Ruby/Rails Dev Environment (gewo/ruby:1.9.3)
FROM gewo/ruby-dependencies
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV APP_RUBY_VERSION 1.9.3-p392
RUN rvm install ruby-${APP_RUBY_VERSION} --default
CMD ["/bin/bash"]
