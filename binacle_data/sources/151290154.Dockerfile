FROM ubuntu:trusty

RUN apt-get -yq update && apt-get -yq upgrade \
  && apt-get -yq install autoconf bison build-essential libssl-dev libyaml-dev \
    libreadline6-dev zlib1g-dev libncurses5-dev curl git openssl

# Ruby
WORKDIR /usr/local/src
RUN git clone https://github.com/sstephenson/ruby-build.git \
  && cd ruby-build \
  && ./install.sh
RUN /usr/local/bin/ruby-build 2.1.5 /usr
RUN /usr/bin/gem install bundler --no-ri --no-rdoc \
    && /usr/bin/bundle config --global jobs 4
ADD Gemfile /usr/local/src/Gemfile
RUN /usr/bin/bundle install

ADD listening.rb /usr/local/bin/listening.rb
