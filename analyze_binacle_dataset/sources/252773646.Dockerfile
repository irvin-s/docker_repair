# vines  
#  
# VERSION 0.4.9  
#  
# Usage:  
#  
FROM ruby  
MAINTAINER Allan Lei "allanlei@helveticode.com"  
# Install coturn  
RUN gem install vines  
  
  
# 5222/tcp: Accepts client connections  
# 5269/tcp: Accepts server connections  
# 5280/tcp: Accepts http connections  
# 5347/tcp: Accepts component connections  
EXPOSE 5222/tcp 5269/tcp 5280/tcp 5347/tcp  
  
  
# 1. vines init DOMAIN  
# 2. cd DOMAIN  
# 3. vines start  
CMD ["vines"]

