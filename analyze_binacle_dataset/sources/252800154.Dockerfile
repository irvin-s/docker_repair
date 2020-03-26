# Description:  
#  
# Docker image for just installing npm modules. Use this  
# to create a docker volume with your npm modules that  
# you can mount elsewhere  
#  
FROM node:6.11-alpine  
MAINTAINER dion@transition9.com  
  
RUN apk add --no-cache make gcc g++ python linux-headers udev git  

