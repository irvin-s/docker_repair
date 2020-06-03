FROM ruby:alpine  
MAINTAINER Manuel Valentino <brisma@gmail.com>  
  
RUN apk --no-cache add mariadb-dev build-base && \  
gem install activerecord -v 4.2 && \  
gem install activesupport -v 4.2 && \  
gem install bson -v 1.10.2 && \  
gem install bson_ext -v 1.10.2 && \  
gem install highline -v 1.6.1 && \  
gem install mongo -v 1.10.2 && \  
gem install mysql2 -v 0.3.21 && \  
gem install mongify -v 1.3.0 && \  
gem install mongify-mongoid -v 1.0.4 && \  
apk del build-base  
  
RUN mkdir -p /mongify  
WORKDIR /mongify  
CMD ["mongify", "-h"]  

