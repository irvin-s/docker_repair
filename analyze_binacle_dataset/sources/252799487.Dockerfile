FROM ruby  
MAINTAINER FandiYuan <georgeyuan@diamondyuan.com>  
  
RUN gem install opendmm  
  
ADD 1.rb 1.rb  
Add /tmp /tmp  
  
CMD ruby 1.rb

