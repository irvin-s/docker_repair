FROM ruby:2.2-slim  
MAINTAINER Albert Dixon <albert@dixon.rocks>  
  
RUN gem install transmission-rss  
ADD config.yml /etc/transmission-rss.conf  
CMD ["transmission-rss"]  

