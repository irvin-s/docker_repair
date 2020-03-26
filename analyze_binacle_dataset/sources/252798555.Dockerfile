FROM ruby:2.1-alpine  
MAINTAINER Michael Clay <MichaelRClay@gmail.com>  
  
EXPOSE 4569  
RUN mkdir -p /fakes3_root  
  
COPY docker-entrypoint.sh /  
  
RUN gem install fakes3 -v 1.2.1  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["fakes3", "-r", "/fakes3_root", "-p", "4569"]  

