FROM alpine:3.3  
MAINTAINER Adam Ladachowski <adam@saiden.pl>  
  
ENV RACK_ENV="production" \  
BUILD_PACKAGES="build-base ruby-dev" \  
RUBY_PACKAGES="ruby ruby-io-console ruby-bundler ruby-unicorn"  
ADD Gemfile* /app/  
RUN echo "gem: --no-ri --no-rdoc" > /root/.gemrc && \  
cd /app/ && apk update && \  
apk upgrade && \  
apk add $BUILD_PACKAGES && \  
apk add $RUBY_PACKAGES && \  
bundle install --without development test && \  
echo $BUILD_PACKAGES && \  
apk del -r $BUILD_PACKAGES && \  
rm -rf /var/cache/apk/*  
  
ADD . /app  
WORKDIR /app  
  
CMD unicorn  

