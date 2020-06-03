FROM bizztreat/docker-ruby-keboola-gd  
  
MAINTAINER Jiri Tobolka <jiri.tobolka@bizztreat.com>  
  
RUN gem install aws-sdk  

