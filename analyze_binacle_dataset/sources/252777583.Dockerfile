FROM node:alpine  
MAINTAINER Antergos Developers <dev@antergos.com>  
  
ARG NODE_ENV  
  
##  
# Install Deps  
##  
RUN apk add --no-cache git coreutils  
  
##  
# Build & Install NodeBB  
##  
RUN git clone https://github.com/nodebb/nodebb /nodebb \  
&& cd /nodebb \  
&& npm install \  
&& npm install --save \  
nodebb-plugin-dbsearch \  
nodebb-plugin-emoji-extended \  
nodebb-plugin-markdown \  
nodebb-plugin-registration-question \  
nodebb-plugin-soundpack-default \  
nodebb-plugin-spam-be-gone \  
nodebb-widget-essentials \  
nodebb-plugin-emailer-mailgun \  
nodebb-plugin-mentions \  
nodebb-plugin-question-and-answer \  
nodebb-plugin-composer-default \  
nodebb-plugin-imgur \  
nodebb-plugin-gravatar \  
nodebb-plugin-ns-likes \  
nodebb-plugin-codeinput \  
nodebb-plugin-ns-login \  
nodebb-plugin-poll \  
nodebb-plugin-write-api \  
nodebb-plugin-emoji-static \  
nodebb-plugin-sso-auth0 \  
nodebb-plugin-topic-tags \  
nodebb-theme-antergos \  
https://github.com/antergos/nodebb-plugin-blog-comments \  
&& rm -rf node_modules \  
&& mkdir -p build/public  
  
ENV NODE_ENV $NODE_ENV  
  
WORKDIR /nodebb  
  
VOLUME [ "/nodebb/build/public" ]  
  
EXPOSE 4567  
  
CMD [ "/entrypoint/nodebb" ]  

