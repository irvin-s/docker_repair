FROM asaaki/elixir-dev:1.1.1  
MAINTAINER Christoph Grabo <asaaki@mannaz.cc>  
  
RUN apk --update add nodejs && rm -rf /var/cache/apk/*  
  
RUN npm update -g npm && npm install -g npm-cache  

