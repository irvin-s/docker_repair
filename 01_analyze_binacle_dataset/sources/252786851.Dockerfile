FROM alpine:3.4  
MAINTAINER Ryan Boyle <ryan@boyle.io>  
  
RUN apk add --update bash && rm -rf /var/cache/apk/*  

