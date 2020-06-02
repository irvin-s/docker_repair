FROM lsiobase/alpine  
MAINTAINER aptalca  
  
# install packages  
RUN \  
apk add --no-cache \  
curl  
  
# add local files  
COPY root/ /  

