#  
# Hyperdex Dockerfile  
# Installs and runs a hyperdex server  
#  
FROM colinrhodes/hyperdex-base  
  
MAINTAINER Colin Rhodes <colin@colin-rhodes.com>  
  
RUN apt-get -yq install hyperdex-coordinator hyperdex-daemon  
  
CMD ["coordinator", "-f"]  
  
VOLUME /data  
  
WORKDIR /data  

