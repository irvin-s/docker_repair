FROM ruby:2.5-alpine  
  
ADD Gemfile .  
ADD Gemfile.lock .  
RUN bundle install  
ADD config.ru .  
CMD ["bundle", "exec", "rackup", "-p9292", "-o0.0.0.0"]  

