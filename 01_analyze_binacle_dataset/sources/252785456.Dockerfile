FROM ruby:2.2.3  
MAINTAINER Chris Olstrom <chris@olstrom.com>  
  
ENV RUBYGEMS_STORAGE /srv/gems  
VOLUME ${RUBYGEMS_STORAGE}  
EXPOSE 3000  
COPY config.ru Gemfile /srv/app/  
COPY lib/ /srv/app/lib/  
WORKDIR /srv/app  
RUN bundle pack  
  
CMD ["bundle", "exec", "reel-rack"]  

