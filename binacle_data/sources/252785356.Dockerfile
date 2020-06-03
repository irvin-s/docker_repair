#  
# Hyperdex Dockerfile  
#  
#  
FROM colinrhodes/hyperdex-base  
  
MAINTAINER Colin Rhodes <colin@colin-rhodes.com>  
  
RUN apt-get -yq install python-hyperdex-client python-hyperdex-admin  

