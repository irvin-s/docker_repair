FROM ruby:alpine  
  
MAINTAINER Jaehoon Choi <plaintext@andromedarabbit.net>  
  
RUN apk -U upgrade && \  
apk --no-cache add curl ca-certificates && \  
update-ca-certificates  
# rm -rf /var/cache/apk/*  
RUN gem install swagger-diff  
# COPY Gemfile .  
COPY sdiff /usr/local/bin/sdiff  
  
CMD ["sdiff"]  

