FROM node:alpine  
MAINTAINER Bastian Widmer <b.widmer@dasrecht.net>  
  
RUN apk add --update bash git python make gcc g++ && rm -rf /var/cache/apk/*  
  
RUN yarn global add https://github.com/notwaldorf/tiny-care-terminal  
RUN yarn global add git-standup  
  
# We need this in order to make emojis work :)  
ENV LANG en_US.UTF-8  
ENTRYPOINT exec /usr/local/bin/tiny-care-terminal  

