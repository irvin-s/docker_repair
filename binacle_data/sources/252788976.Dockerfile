#  
# nullstar  
# Copyright(c) 2016 Nicholas Penree <nick@penree.com>  
# MIT Licensed  
#  
FROM node:6-onbuild  
MAINTAINER Nicholas Penree <nick@penree.com>  
  
VOLUME /tmp/repl  
VOLUME /usr/src/app/config.json  
VOLUME /usr/src/app/logs  
VOLUME /usr/src/app/data

