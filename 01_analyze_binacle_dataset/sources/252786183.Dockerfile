FROM ruby:2.3.1-onbuild  
  
MAINTAINER Dmitry Momot <mail@dmomot.com>  
  
RUN apt-get update && apt-get install -y nodejs \  
&& apt-get clean && rm -rf /var/lib/apt/lists/*  

