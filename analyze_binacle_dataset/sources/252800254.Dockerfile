########################################################################  
# Dockerfile for a minimal empty docker image to act as data container  
#  
# ## .  
# ## ## ## ==  
# ## ## ## ## ===  
# /""""""""""""""""\\___/ ===  
# ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ / ===- ~~~  
# \\______ o __/  
# \ \ __/  
# \\____\\______/  
#  
# Component:  
# Author: pjan vandaele <pjan@pjan.io>  
# Scm url: https://github.com/docxs/docker-scratch  
# License: MIT  
########################################################################  
  
# pull base image  
FROM scratch  
  
# maintainer details  
MAINTAINER pjan vandaele "pjan@pjan.io"  
  
VOLUME /data  
  
CMD []  
  
ENTRYPOINT ["/data"]  

