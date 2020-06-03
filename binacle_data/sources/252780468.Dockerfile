FROM alpine:3.6  
  
RUN addgroup alpine && adduser -G alpine -s /bin/sh -D alpine && \  
apk add \--update bash ruby ruby-rdoc ruby-irb ruby-bundler ruby-dev && \  
gem install mustache && \  
apk del ruby-rdoc ruby-irb ruby-bundler ruby-dev && \  
rm -rf /apk /tmp/* /var/cache/apk/* && \  
mkdir /data && chown -R alpine:alpine /data  
  
USER alpine  
WORKDIR /data  
  
ENTRYPOINT ["mustache"]  

