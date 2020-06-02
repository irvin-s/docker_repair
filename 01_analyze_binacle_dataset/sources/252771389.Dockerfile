FROM ruby:alpine  
  
MAINTAINER Aidan Hamwood <ajh@tuta.io>  
  
RUN apk add --no-cache --update --virtual .build-deps build-base \  
&& apk add --no-cache --update libstdc++ && \  
echo 'gem: --no-rdoc --no-ri ' >> ~/.gemrc  
  
ADD Gemfile /app/  
ADD Gemfile.lock /app/  
  
RUN gem install bundler && \  
cd /app; bundle install --clean --jobs=4 && gem clean && \  
apk del .build-deps  
  
EXPOSE 80  
ADD . /app/  
CMD ["foreman", "start", "-d", "/app"]  

