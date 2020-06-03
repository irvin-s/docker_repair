FROM library/ruby:2.4-alpine  
  
LABEL maintainer peterc@aetheric.co.nz  
  
RUN apk add --no-cache \  
build-base \  
libxml2-dev \  
libxslt-dev  
  
RUN gem install nokogiri -- \  
\--use-system-libraries  
  
RUN gem install \  
devtools \  
gorgeous  
  
WORKDIR /usr/work  
VOLUME /usr/work  
ENTRYPOINT [ "gorgeous" ]  
CMD [ "--help" ]  
  

