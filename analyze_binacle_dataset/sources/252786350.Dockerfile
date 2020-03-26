FROM dock0/ruby  
MAINTAINER akerl <me@lesaker.org>  
RUN gem install --no-user-install foreman  
ADD run /service/foreman/run  
ENV RACK_ENV production  

