FROM alpine:3.7  
  
LABEL vendor="bokazio" origin="https://github.com/bokazio/docker-ci-deploy"  
# Install Build & Deployment Tools & clean up  
RUN \  
apk add --no-cache \  
dumb-init \  
bash \  
git \  
openssh-client \  
rsync \  
ruby \  
ruby-io-console \  
build-base \  
libffi-dev \  
ruby-dev \  
ca-certificates \  
py-yuicompressor && \  
gem install sass --no-ri --no-rdoc && \  
apk del build-base libffi-dev ruby-dev && \  
rm -rf /var/cache/apk/*  
  

