FROM ruby:alpine  
  
MAINTAINER abcang <abcang1015@gmail.com>  
  
RUN apk add --update make g++ && \  
gem install slack_twitter_egosa && \  
apk del make && \  
rm -rf /var/cache/apk/*  
  
CMD ["slack_twitter_egosa"]  

