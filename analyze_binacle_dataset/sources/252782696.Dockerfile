FROM debian:wheezy  
MAINTAINER Clif Reeder clifreeder@gmail.com  
  
RUN apt-get -y update && \  
apt-get -y install build-essential ruby1.9.3 && \  
gem install bundler  
  
ADD Gemfile Gemfile  
ADD Gemfile.lock Gemfile.lock  
RUN bundle install  
  
ADD dance_anthems.rb dance_anthems.rb  
CMD ["ruby", "dance_anthems.rb"]  

