#  
# DesertBit Golang GB Dockerfile  
#  
FROM desertbit/golang-gb:1.5-alpine  
  
MAINTAINER Roland Singer, roland.singer@desertbit.com  
  
# Run the run application in the projects bin directory.  
CMD [ "app" ]  
  
# On build triggers.  
ONBUILD COPY . $PROPATH  
ONBUILD RUN gb build all  

