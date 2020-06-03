FROM ubuntu:14.04.3  
MAINTAINER ekho@ekho.name  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install git  
RUN apt-get update -qq  
  
RUN apt-get install -qqy git  
  
ADD git-daemon.sh /usr/bin/git-daemon.sh  
VOLUME /git  
  
# git daemon ports  
EXPOSE 9418  
CMD /usr/bin/git-daemon.sh  

