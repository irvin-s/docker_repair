FROM ruby:2.4.0-alpine  
  
RUN apk add --no-cache build-base git \  
&& gem install travis -v 1.8.6 --no-rdoc --no-ri \  
&& apk del build-base \  
&& mkdir /repo  
  
WORKDIR /repo  
  
ENTRYPOINT ["travis"]  

