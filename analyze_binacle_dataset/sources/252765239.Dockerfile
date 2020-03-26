FROM ruby:2.2  
MAINTAINER Jan Dalheimer <jan@dalheimer.de>  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
VOLUME /usr/src/app/out  
EXPOSE 80  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
COPY sep.rb /usr/src/app/  
  
RUN bundle install  
  
ENV SEP_PORT 80  
ENV SEP_OUTDIR /usr/src/app/out  
  
CMD bundle exec ./sep.rb  

