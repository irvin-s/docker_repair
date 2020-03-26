FROM aurorasystem/base-service  
MAINTAINER Aurora System <it@aurora-system.com>  
  
RUN useradd -ms /bin/bash deploy  
USER deploy  
RUN mkdir -p /home/deploy/app  
WORKDIR /home/deploy/app  

