FROM mhart/alpine-node:7  
  
ENV SYSTEM_PKGS curl wget bash git openssh  
  
RUN apk update && \  
apk add $SYSTEM_PKGS && \  
rm /bin/sh && ln -s /bin/bash /bin/sh && \  
git --version && \  
which ssh  

