FROM edib/elixir-dev:1.4  
MAINTAINER Christoph Grabo <edib@markentier.com>  
  
# node + npm  
RUN apk --no-cache upgrade && \  
apk --no-cache add nodejs nodejs-npm yarn && \  
npm update -g npm  

