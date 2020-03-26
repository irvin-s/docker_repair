FROM ruby:2  
MAINTAINER Eddú Meléndez<eddu.melendez@gmail.com>  
  
RUN gem install fastlane -v 2.28.9  
  
ENTRYPOINT ["fastlane"]  

