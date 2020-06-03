FROM phusion/baseimage:0.9.11
MAINTAINER Lien Chiang <xsoameix@gmail.com>

# Install berkshelf
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y
RUN apt-get install -y curl libxml2-dev libxslt-dev git \
                       autoconf automake build-essential
RUN curl -L https://www.opscode.com/chef/install.sh | bash
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN /opt/chef/embedded/bin/gem install berkshelf

# install dependencies
ADD package.json app/package.json

# Use cookbooks
ADD docker/cookbooks/ly.g0v.tw /chef
RUN cd /chef && LC_ALL=en_US.UTF-8 /opt/chef/embedded/bin/berks vendor cookbooks
RUN chef-solo -c /chef/solo.rb -j /chef/solo.json
