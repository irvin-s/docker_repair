# Ruby/Rails Dev Environment (gewo/ruby)
FROM gewo/ruby-dependencies
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV APP_RUBY_VERSION 2.1.2
RUN rvm install ruby-${APP_RUBY_VERSION} --default
CMD ["/bin/bash"]
