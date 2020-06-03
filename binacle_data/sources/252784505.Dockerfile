FROM ruby:2.3.1  
MAINTAINER Björn Heneka <bheneka@codebee.de>  
  
RUN gem install capistrano -v "=3.5.0" && \  
gem install cabin \  
childprocess \  
gem-wrappers \  
ffi \  
executable-hooks \  
arr-pm \  
backports  
  
ADD cap.sh /cap.sh  
RUN chmod +x /cap.sh

