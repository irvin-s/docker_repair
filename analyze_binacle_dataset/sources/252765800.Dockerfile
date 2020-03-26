FROM ruby:2.2-alpine  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN apk add --no-cache git build-base linux-headers  
COPY Gemfile* /usr/src/app/  
RUN bundle install -j4 --path vendor/bundle --without 'development test'  
COPY config.ru /usr/src/app  
  
EXPOSE 8080  
ENV RACK_ENV=production  
CMD ["bundle", "exec", "rackup", "-p", "8080", "-o", "0.0.0.0", "config.ru"]  

