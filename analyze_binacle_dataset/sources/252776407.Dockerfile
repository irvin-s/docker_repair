FROM node:6-alpine  
  
RUN set -ex \  
&& mkdir -p /srv  
  
ADD . /srv  
  
WORKDIR /srv  
  
# trigger  
RUN set -ex \  
&& npm install -g \  
&& npm link

