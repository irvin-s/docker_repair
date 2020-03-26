FROM alpine:3.4  
MAINTAINER dino@dinofizzotti.com  
  
RUN apk --update add \  
rsync \  
openssh \  
&& \  
rm -rf /var/cache/apk/*  

