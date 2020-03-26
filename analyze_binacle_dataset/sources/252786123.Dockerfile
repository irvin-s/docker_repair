FROM node:8-alpine  
  
# Add packages needed to build native dependencies  
RUN apk add \--no-cache \  
git \  
python \  
python-dev \  
py-pip \  
build-base \  
libc6-compat \  
&& pip install virtualenv  
  
# install angular-cli as node user  
RUN chown -R node:node /usr/local/lib/node_modules \  
&& chown -R node:node /usr/local/bin  
  
USER node  
RUN npm install -g @angular/cli@1.7.3  
  
# set npm as default package manager for root  
USER root  
RUN ng set \--global packageManager=npm

