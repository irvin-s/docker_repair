FROM avvo/alpine:3.5  
MAINTAINER Avvo Infrastructure Team <infrastructure@avvo.com>  
  
RUN apk update && \  
apk upgrade && \  
apk add \  
build-base \  
ca-certificates \  
libffi-dev \  
libressl-dev \  
libxml2-dev \  
libxslt-dev \  
linux-headers \  
'ruby<2.4' \  
ruby-bigdecimal \  
ruby-dev \  
ruby-io-console \  
ruby-irb \  
ruby-json \  
ruby-libs \  
ruby-minitest \  
ruby-rake \  
ruby-rdoc \  
tzdata \  
zlib-dev && \  
rm -rf /var/cache/apk/* && \  
update-ca-certificates && \  
mkdir -p /srv && \  
gem install --no-document bundler -v 1.15.1 && \  
bundle config build.nokogiri --use-system-libraries  
  
CMD ["/usr/bin/ruby", "--version"]  

