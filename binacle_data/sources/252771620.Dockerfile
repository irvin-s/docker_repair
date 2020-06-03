FROM maven  
  
MAINTAINER astromatch <astromatch.ti@gmail.com>  
  
RUN apt-get update && apt-get upgrade -y; \  
apt-get install build-essential -y

