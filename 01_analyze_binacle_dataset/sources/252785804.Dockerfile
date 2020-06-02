FROM ruby:2.4.1-alpine  
  
ENV COMPASS_VERSION 1.0.3  
RUN apk add --no-cache --virtual .gem-build-deps build-base && \  
gem install compass -v $COMPASS_VERSION && \  
apk del .gem-build-deps  
  
WORKDIR /workdir  
COPY entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["entrypoint.sh"]  
  

