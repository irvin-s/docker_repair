################################################################  
  
# Dockerfile to build AOSSL Container Images  
# Based on Ubuntu-ssh  
  
################################################################  
  
#Based on Ubuntu 16.04  
FROM ubuntu:16.04  
  
#Set the Maintainer  
MAINTAINER Alex Barry  
  
#Set up front end  
ENV DEBIAN_FRONTEND noninteractive  
  
#Setup necessary components for building the library  
ADD ./scripts/deb/build_deps.sh .  
  
#Setup basic environment tools  
RUN ./build_deps.sh  
  
#Expose some of the default ports  
EXPOSE 22  
EXPOSE 5555  
EXPOSE 5556  
EXPOSE 8091  
EXPOSE 8092  
EXPOSE 8093  
EXPOSE 11210  
EXPOSE 12345  
  
#Pull the project source from github  
RUN git clone https://github.com/AO-StreetArt/AOSharedServiceLibrary.git  
  
#Install the library  
RUN cd AOSharedServiceLibrary && make && make install  
  
#Start up the SSH terminal so that we can connect & start the app  
CMD tail -f /dev/null  

