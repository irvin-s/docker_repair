FROM ruby:2.3-alpine  
MAINTAINER bluebu <bluebuwang@gmail.com>  
  
ENV RAILS_VERSION="4.2.7" \  
BUILD_PACKAGES="curl-dev build-base openssh" \  
DEV_PACKAGES="tzdata libxml2 libxml2-dev libxslt libxslt-dev mysql-client \  
imagemagick imagemagick-dev mysql-dev sqlite-dev git nodejs"  
RUN \  
apk --update --upgrade add $BUILD_PACKAGES $DEV_PACKAGES && \  
rm /var/cache/apk/*  
  
RUN \  
gem install -N nokogiri && \  
gem install -N rails --version "$RAILS_VERSION" && \  
echo 'gem: --no-document' >> ~/.gemrc && \  
cp ~/.gemrc /etc/gemrc && \  
chmod uog+r /etc/gemrc && \  
  
# cleanup and settings  
# bundle config --global build.nokogiri "--use-system-libraries" && \  
# bundle config --global build.nokogumbo "--use-system-libraries" && \  
rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \  
rm -rf ~/.gem  
  
CMD [ "/bin/sh" ]  

