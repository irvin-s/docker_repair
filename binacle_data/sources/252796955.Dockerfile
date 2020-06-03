FROM ruby:2.2-alpine  
  
MAINTAINER closeyourhead  
  
RUN apk --update --no-cache add \  
build-base \  
libstdc++ \  
sqlite-dev \  
sqlite-libs && \  
gem install mailcatcher -v 0.6.4 --no-ri --no-rdoc && \  
apk del build-base sqlite-dev  
  
EXPOSE 1025 1080  
CMD ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]  
  

