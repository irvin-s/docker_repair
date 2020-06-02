# vim:set ft=dockerfile:  
FROM andrius/alpine-ruby:latest  
  
MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>  
  
RUN apk add --update build-base ruby-dev \  
&& gem install --no-rdoc --no-ri json tugboat \  
&& apk del build-base ruby-dev \  
&& rm -rf /usr/lib/ruby/gems/*/cache/* \  
&& rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["tugboat"]  
CMD ["--help"]  
  

