FROM ruby:alpine  
MAINTAINER dan@jsquad.net  
  
ENV BUILD_PACKAGES build-base nodejs  
ENV RUBY_PACKAGES py-pygments  
RUN apk update && \  
apk upgrade && \  
apk add $BUILD_PACKAGES && \  
apk add $RUBY_PACKAGES && \  
rm -rf /var/cache/apk/*  
  
RUN gem install jekyll rdiscount kramdown jekyll-redirect-from rouge  
  
VOLUME /src  
EXPOSE 4000  
WORKDIR /src  
ENTRYPOINT ["jekyll"]  

