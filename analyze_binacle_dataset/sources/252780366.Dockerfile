FROM alpine:3.5  
MAINTAINER Azzra <azzra@users.noreply.github.com>  
  
RUN apk add --no-cache \  
python \  
make \  
g++ \  
nodejs  
  
RUN npm install -g \  
webdriverio  
  
ENV FRAMEWORKS wdio-mocha-framework wdio-jasmine-framework  
ENV REPORTERS wdio-dot-reporter wdio-spec-reporter  
RUN npm install -g $FRAMEWORKS $REPORTERS  
  
WORKDIR /tests  
  
COPY ./docker-entrypoint.sh /root/scripts/docker-entrypoint.sh  
  
ENV SELENIUM_HOST localhost  
ENV SELENIUM_PORT 4444  
ENTRYPOINT ["/root/scripts/docker-entrypoint.sh"]  

