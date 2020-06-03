FROM ruby:2.3-alpine  
# NOTE: to slim down this image we could uninstall the build-base after  
# running bundle install:  
# http://blog.kontena.io/building-minimal-docker-image-for-rails/  
RUN apk add --update build-base && rm -rf /var/cache/apk/*  
RUN mkdir /usr/src/app  
WORKDIR /usr/src/app/  
ADD Gemfile /usr/src/app/Gemfile  
ADD Gemfile.lock /usr/src/app/Gemfile.lock  
RUN bundle install  
ADD . /usr/src/app/  
CMD ["ruby", "./main.rb"]

