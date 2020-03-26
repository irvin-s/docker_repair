FROM ruby:2.2  
MAINTAINER Jan Dalheimer <jan@dalheimer.de>  
  
RUN mkdir -p /usr/src/app /out  
WORKDIR /usr/src/app  
  
ENV WTS_OUT_DIR /usr/src/app/out  
VOLUME /usr/src/app/out /usr/src/app/cache  
  
RUN gem install -v 0.1.4 wonko_the_sane  
  
CMD wonko_the_sane --refresh-all  

