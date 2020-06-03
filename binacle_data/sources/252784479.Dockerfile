FROM ruby:2.1  
MAINTAINER Jiri Tobolka <jiri.tobolka@bizztreat.com>  
  
RUN gem install rest-client  
RUN gem install gooddata  

