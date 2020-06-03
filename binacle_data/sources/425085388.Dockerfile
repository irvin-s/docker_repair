# Ruby/Rails Dev Environment (gewo/ruby)
FROM gewo/ruby-dependencies
MAINTAINER Gebhard Wöstemeyer <g@ctr.lc>

ENV APP_RUBY_VERSION 2.3.3
RUN rvm install ruby-${APP_RUBY_VERSION} --default

# FIXME: /usr/local/rvm/gemsets/global.gems is lost...
RUN rvm-shell -c 'rvm @global do gem install bundler'

CMD ["/bin/bash"]
