FROM ruby:2.4-alpine3.7  
  
RUN apk add \--no-cache \  
alpine-sdk=0.5-r0 \  
libxml2-dev=2.9.7-r0 \  
libxslt-dev=1.1.31-r0 \  
&& gem install nokogiri \  
\--version 1.8.2 \  
\-- --use-system-libraries \  
\--with-xml2-config=/usr/bin/xml2-config \  
\--with-xslt-config=/usr/bin/xslt-config \  
&& gem install erb_lint  
  
WORKDIR /workdir  
ENTRYPOINT ["erblint"]  

