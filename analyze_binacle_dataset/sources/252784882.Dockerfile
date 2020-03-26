FROM ubuntu:xenial  
MAINTAINER Thomas Schulze <tschulze@codemonauts.com>  
  
RUN apt-get update && apt-get -y install imagemagick ghostscript rename vim  
ADD includes /  

