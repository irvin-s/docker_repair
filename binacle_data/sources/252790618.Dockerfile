FROM alpine:latest  
MAINTAINER Carl Saturnino <cosaturn@gmail.com>  
  
ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base  
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler  
  
# Update and install all of the required packages.  
# At the end, remove the apk cache  
RUN apk update && \  
apk upgrade && \  
apk add $BUILD_PACKAGES && \  
apk add $RUBY_PACKAGES && \  
rm -rf /var/cache/apk/*  
  
RUN gem install --no-document io-console t  
ENTRYPOINT ["t"]  

