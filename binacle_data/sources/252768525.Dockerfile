FROM ruby:2.3.0  
WORKDIR /usr/src/app/  
RUN gem install capistrano --version=3.4.0 &&\  
gem install capistrano-scm-local --version=0.1.17  

