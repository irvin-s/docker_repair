FROM ruby:2.3  
MAINTAINER "Dave Long <dlong@cagedata.com>"  
ARG version=0.43.0  
RUN gem install rubocop -v ${version}  
  
WORKDIR /app  
VOLUME /app  
  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  

