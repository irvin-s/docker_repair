#  
# DesertBit Watchman Dockerfile  
#  
FROM golang:onbuild  
MAINTAINER Roland Singer, roland.singer@desertbit.com  
  
EXPOSE 80  
VOLUME ["/config"]  
  
ENV WATCHMAN_DIR /config

