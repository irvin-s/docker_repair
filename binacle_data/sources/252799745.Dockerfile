FROM dieterkoch/ruby-node:2.4.4-alpine  
MAINTAINER Dieter Koch <dk@dkoch.org>  
  
# Install additional packages required to install gems.  
RUN apk update && \  
apk upgrade && \  
apk --update add \  
build-base \  
git \  
libc-dev \  
libffi-dev \  
libxml2-dev \  
libxslt-dev \  
linux-headers \  
libressl-dev \  
postgresql-dev \  
ruby-dev \  
yarn  
  
# Configure gem and bundler  
RUN echo 'gem: --no-document' > /etc/gemrc && \  
bundle config build.nokogiri --use-system-libraries  

