FROM ruby:2.3-alpine  
LABEL maintainer="Josh Mostafa <jmostafa@cozero.com.au>"  
  
ENV RUBOCOP_VERSION=0.52.1  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/* \  
&& gem install rubocop -v ${RUBOCOP_VERSION}  
  
WORKDIR /app  
VOLUME /app  
  
COPY rubocop.sh /rubocop.sh  
ENTRYPOINT ["/rubocop.sh"]  

