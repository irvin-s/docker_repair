FROM dockercraft/alpine:3.7  
MAINTAINER Daniel <daniel@topdevbox.com>  
  
# How-To  
# Local Build: docker build -t bundler .  
# Local Run: docker run -it bundler bundler help  
ENV PACKAGES "g++ make ruby ruby-dev ruby-json nodejs zlib-dev"  
# optinal package: curl gmp-dev ca-certificates openssl openssl-dev musl-dev  
RUN apk update \  
&& apk upgrade \  
&& apk add --update $PACKAGES \  
&& echo 'gem: --no-document' > /etc/gemrc \  
&& gem install bundler \  
&& rm -rf /var/cache/apk/*  
  

