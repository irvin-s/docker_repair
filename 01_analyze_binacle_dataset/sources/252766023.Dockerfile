FROM ruby  
MAINTAINER Fabio Hisamoto <fabio@99taxis.com>  
  
RUN gem install specific_install  
RUN gem specific_install https://github.com/fhisamoto/fake_sns.git  
  
EXPOSE 9292  
ENV RACK_ENV=production  

