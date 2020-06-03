FROM ruby:2.4  
MAINTAINER Devin Nathan-Turner <devin@dnt.tech>  
  
WORKDIR /work  
  
RUN gem install brakeman  
  
ENTRYPOINT ["brakeman"]  

