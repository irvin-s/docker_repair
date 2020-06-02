FROM node:9-alpine  
  
LABEL vendor="bokazio" origin="https://github.com/bokazio/docker-ci-frontend"  
# Install Polymer Build & Deployment Tools & clean up  
RUN \  
apk add --no-cache \  
dumb-init \  
bash \  
git \  
openssh-client \  
rsync \  
ca-certificates && \  
npm install npm@latest -g && \  
npm install -g bower && \  
npm install -g polymer-cli --unsafe-perm && \  
npm install -g gulp-cli && \  
rm -rf /var/cache/apk/*  

