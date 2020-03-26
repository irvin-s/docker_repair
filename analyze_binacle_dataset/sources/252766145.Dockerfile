FROM ruby:2.3  
LABEL MAINTAINER="Aaron Trout <aaron@trouter.co.uk>"  
  
RUN gem install fog activesupport:5.0.2 mime-types  

