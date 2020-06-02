FROM ruby:2.3.0-onbuild  
MAINTAINER Steven Jack <stevenmajack@gmail.com>  
  
EXPOSE 9292  
ENTRYPOINT ["rackup", "--host", "0.0.0.0"]  

