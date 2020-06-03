FROM mhart/alpine-node:8.6.0  
MAINTAINER Ryan Kes <ryan@andthensome.nl>  
  
ADD VERSION .  
  
ARG BUILD_DATE  
ARG VCS_REF  
ARG VCS_URL  
  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.vcs-url=$VCS_URL \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.schema-version="1.0.0-rc1"  
  
# Install pygments (for syntax highlighting)  
RUN apk update && apk add bash && rm -rf /var/cache/apk/*  
  
# Install surge client  
RUN yarn global add surge@0.19.0  

