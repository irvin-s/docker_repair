FROM quay.io/modcloth/ruby-dev:latest
MAINTAINER Dan Buch <d.buch@modcloth.com>

RUN /usr/local/rvm/bin/rvm install 2.0.0-p247
RUN /usr/local/rvm/wrappers/ruby-2.0.0-p247/gem install bundler
ENV PATH /usr/local/rvm/wrappers/ruby-2.0.0-p247:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
