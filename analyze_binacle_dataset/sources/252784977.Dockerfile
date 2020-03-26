#  
# Ruby Dockerfile  
#  
# https://github.com/coderjoe/dockerfile-ruby  
#  
FROM coderjoe/ruby-install  
MAINTAINER Joseph Bauser <coderjoe@coderjoe.net>  
  
# Set our version to install  
ENV RUBY_VERSION 2.2.2  
# Install ruby  
RUN ruby-install ruby $RUBY_VERSION  
  
# Build our ruby environment  
ENV PATH=/opt/rubies/ruby-$RUBY_VERSION/bin:$PATH  
RUN echo 'gem: --no-ri --no-rdoc' > /etc/gemrc  

