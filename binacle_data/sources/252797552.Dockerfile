FROM ruby:2.3-alpine  
MAINTAINER cnosuke  
  
RUN apk update  
RUN apk add --no-cache bash mysql-client lz4  
RUN mkdir -p /tmp/backups  
RUN mkdir -p /tmp/lz4  
  
ADD backup.rb .  
RUN chmod +x backup.rb  
  
CMD ["./backup.rb"]  

