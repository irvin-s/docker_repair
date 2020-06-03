from alpine  
  
RUN apk update && apk upgrade  
RUN apk add ruby \  
ruby-bundler \  
ruby-dev  
RUN rm -rf /var/cache/apk/*  
RUN gem install puppet-lint --no-document  
  
VOLUME /modules  
ENTRYPOINT ["puppet-lint"]  
CMD ["/modules"]  

