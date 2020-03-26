FROM alpine  
MAINTAINER Dogstudio <developers@dogstudio.be>  
  
RUN apk add --no-cache rsync lsyncd  
  
WORKDIR /src  
VOLUME /var/www  
  
CMD lsyncd -delay 1 -nodaemon -rsync /src /var/www  

