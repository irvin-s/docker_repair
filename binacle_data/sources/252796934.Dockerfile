FROM ruby:alpine  
MAINTAINER Derek Smith <drsmith.phys@gmail.com>  
  
# Make ap dir  
RUN mkdir -p /usr/src/sidekiq  
WORKDIR /usr/src/sidekiq  
  
# ADD Gemfile  
ADD Gemfile /usr/src/sidekiq/  
ADD Gemfile.lock /usr/src/sidekiq/  
  
# Install sidekiq & rack  
RUN bundle install  
  
# ADD rackup file  
ADD config.ru /usr/src/sidekiq/  
  
# ADD the docker entrypoint  
ADD docker-entrypoint.sh /  
  
EXPOSE 9292  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "config.ru"]  

