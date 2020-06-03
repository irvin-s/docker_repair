FROM ruby:2.3  
MAINTAINER Viciware LLC  
  
EXPOSE 3000  
VOLUME /usr/src/app/public  
  
# throw errors if Gemfile has been modified since Gemfile.lock  
RUN bundle config --global frozen 1  
  
ENV RAILS_ENV=production  
  
RUN mkdir -p /usr/src/app  
  
ADD Gemfile /tmp/  
ADD Gemfile.lock /tmp/  
  
WORKDIR /tmp  
RUN bundle install  
  
ADD . /usr/src/app  
  
WORKDIR /usr/src/app  
  
CMD ["bin/start"]  

