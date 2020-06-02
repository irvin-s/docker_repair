FROM alpine  
  
RUN apk update  
  
RUN apk add \  
ruby \  
ruby-dev \  
ruby-json \  
build-base \  
zlib-dev \  
tzdata  
  
RUN gem install --no-document tower_bridge_lifts  
  
### CLEANUP  
RUN rm -rf /var/cache/apk/*  
RUN rm -rf /usr/lib/ruby/gems/*/cache/*  
  
ENV RACK_ENV production  
EXPOSE 8080  
CMD ["tblifts", "server", "-p8080"]  

