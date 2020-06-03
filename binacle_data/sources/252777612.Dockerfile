FROM docker:1.11  
  
RUN apk update && \  
apk add \  
ca-certificates \  
git \  
ruby \  
ruby-dev \  
build-base \  
perl \  
libffi-dev \  
bash && \  
gem install --no-ri --no-rdoc \  
mixlib-shellout \  
berkshelf \  
chef && \  
apk del \  
libffi-dev \  
perl \  
build-base && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["chef-solo"]  
CMD ["-h"]  
  

