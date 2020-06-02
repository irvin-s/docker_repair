FROM ubuntu:14.04  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN apt-get update && apt-get -y install sikuli-ide && apt-get clean  
  
# See: https://bugs.launchpad.net/ubuntu/+source/sikuli/+bug/1313398  
ADD sikuli-ide /usr/bin/  
  
WORKDIR /tmp  
ENTRYPOINT ["/usr/bin/sikuli-ide"]  

