FROM ruby:onbuild  
CMD rackup config.ru  
EXPOSE 9292  

