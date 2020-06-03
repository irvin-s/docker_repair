FROM ruby:2.4  
RUN gem install package_cloud rest-client  
ADD prune.rb /  

