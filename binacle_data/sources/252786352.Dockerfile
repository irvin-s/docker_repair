FROM dock0/ruby  
MAINTAINER akerl <me@lesaker.org>  
ADD runner /service/runner/run  
ADD source /opt/source  
RUN bundle install --gemfile /opt/source/Gemfile  

