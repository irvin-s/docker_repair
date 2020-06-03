FROM ruby:alpine  
  
RUN apk add --no-cache --virtual .gem-build-deps build-base && \  
apk --no-cache add mariadb-dev && \  
gem install mysql2 ridgepole && \  
apk del .gem-build-deps && \  
rm /usr/lib/libmysqld* && \  
rm /usr/bin/mysql*  
  
WORKDIR /ridgepole  
ENTRYPOINT ["ridgepole"]  

