FROM betacz/baseimage-zh  
MAINTAINER Beta CZ <hlj8080@gmail.com>  
  
ENV HOME /root  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
# ruby 2.1.3  
# From: https://github.com/docker-library/ruby/blob/master/2.1/Dockerfile  
RUN apt-get update && apt-get install -y curl \  
procps\  
build-essential \  
zlib1g-dev \  
libssl-dev \  
libreadline6-dev \  
libyaml-dev  
  
ENV RUBY_MAJOR 2.1  
ENV RUBY_VERSION 2.1.3  
ADD http://cache.ruby-lang.org/pub/ruby/2.1/ruby-$RUBY_VERSION.tar.gz /tmp/  
RUN cd /tmp && \  
tar -xzf ruby-$RUBY_VERSION.tar.gz && \  
cd ruby-$RUBY_VERSION && \  
./configure && \  
make && \  
make install && \  
cd .. && \  
rm -rf ruby-$RUBY_VERSION && \  
rm -f ruby-$RUBY_VERSION.tar.gz  
  
# Set the gem sources to mirrors.aliyun.com/rubygems/  
RUN gem sources --remove https://rubygems.org/  
RUN gem sources -a http://mirrors.aliyun.com/rubygems/  
  
# skip installing gem documentation  
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc  
  
RUN gem install bundler  
  
# workaround for $HOME  
RUN echo /root > /etc/container_environment/HOME  
  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

