FROM ruby:2.3  
MAINTAINER Aristotelis Christou <telischristou@gmail.com>  
  
  
RUN mkdir data  
EXPOSE 9292  
RUN mkdir -p /usr/src/app  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
WORKDIR /usr/src/app  
RUN bundle install  
  
COPY . /usr/src/app  
  
ENTRYPOINT ["passenger", "start", "-p", "9292", "-e", "production"]  

