FROM ruby:2.2.7-alpine  
  
ADD Gemfile* /app/  
  
RUN apk add --no-cache --virtual .build-deps build-base \  
&& cd /app; bundle install \  
&& apk del .build-deps  
  
ADD . /app  
WORKDIR /app  
  
CMD ["ruby", "comcast-bandwidth.rb"]  

