FROM dockerfile/ubuntu

MAINTAINER Cyrill Schumacher <cyrill@zookal.com>

# Do not try to prompt for config
ENV DEBIAN_FRONTEND noninteractive

# Install Ruby2.1
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update && apt-get install -y build-essential ruby2.1 ruby2.1-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install bundler
RUN gem install bundler --no-rdoc --no-ri

RUN apt-get install -y libsqlite3-dev
RUN gem install mailcatcher --no-ri --no-rdoc

# https://github.com/sj26/mailcatcher/issues/155
# mailcatcher failed to start #155
# @todo check later if there is a cool solution
RUN gem install i18n -v 0.6.11
RUN gem uninstall i18n -Ix --version '>0.6.11'

EXPOSE 1080
EXPOSE 25
CMD mailcatcher --smtp-port 25 --ip `ip addr show dev eth0 scope global | grep inet | awk '{print $2;}' | cut -d/ -f1` -f
