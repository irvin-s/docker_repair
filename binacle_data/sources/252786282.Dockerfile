#############################################  
# File: kali-base/Dockerfile  
# Author: Donald Raikes <don.raikes@oracle.com>  
# Date: 12/16/2016  
#  
# Base kalilinux 2016 image.  
#############################################  
FROM kalilinux/kali-linux-docker  
MAINTAINER Donald Raikes  
RUN apt-get -yq update && apt-get -yq dist-upgrade  
RUN apt-get install -y aptitude vim  
ENTRYPOINT /bin/bash  

