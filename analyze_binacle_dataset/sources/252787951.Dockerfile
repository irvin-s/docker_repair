FROM ruby  
  
MAINTAINER Joost Cassee <joost@cassee.net>  
  
WORKDIR /src  
  
RUN gem install relish  
  
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint  
RUN chmod 755 /usr/local/bin/docker-entrypoint  
  
ENTRYPOINT ["docker-entrypoint"]  

